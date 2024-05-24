#!/usr/bin/swift

import Foundation

let fileManager = FileManager.default
let currentDirectoryPath = fileManager.currentDirectoryPath
processLogFiles(in: currentDirectoryPath, using: fileManager)

func processLogFiles(
    in directoryPath: String,
    using fileManager: FileManager
) {
    print("Reading log files in `\(directoryPath)`")
    
    let inputFiles = UnprocessedLogFilesProvider(
        directoryPath: directoryPath,
        fileManager: fileManager
    )
    .readFiles()
    
    print("Did read \(inputFiles.count) log files")
    
    inputFiles.forEach(processFile)
    
    print("Done")
}

func processFile(
    _ file: UnprocessedLogFile
) {
    do {
        print("Processing `\(file.name)`...")
        
        let outputURL = try LogFileProcessor(logFile: file).processFile()
        
        print("Did finish processing `\(file.name)`. File saved as `\(outputURL.path())`")
    } catch {
        print("Did fail processing `\(file.name)`: \(error)")
    }
}

// MARK: - Helpers

struct UnprocessedLogFilesProvider {
    let directoryPath: String
    let fileManager: FileManager
    
    func readFiles() -> [UnprocessedLogFile] {
        guard let enumerator = fileManager.enumerator(atPath: directoryPath) else { return [] }
        return enumerator.compactMap {
            guard let fileName = $0 as? String else { return nil }
            return try? UnprocessedLogFile(
                fileName: fileName,
                inDirectory: directoryPath
            )
        }
    }
}

struct UnprocessedLogFile {
    enum Failure: Error {
        case notALogFile(String)
        case alreadyProcessed(String)
    }
    
    let url: URL
    var name: String { url.lastPathComponent }
    
    init(
        fileName: String,
        inDirectory directoryPath: String
    ) throws {
        guard fileName.hasSuffix(".logs") else { 
            throw Failure.notALogFile(fileName)
        }
        guard !fileName.contains("_processed") else {
            throw Failure.alreadyProcessed(fileName)
        }
        self.url = URL(
            filePath: directoryPath.appending("/").appending(fileName)
        )
    }
}

struct LogFileProcessor {
    let logFile: UnprocessedLogFile
    
    func processFile() throws -> URL {
        let inputString = try String(contentsOf: logFile.url)
        let components = inputString.components(separatedBy: "\n\n")
        let processed = components.map(processFileComponent)
        let outputString = processed.joined(separator: "\n\n")
        let outputURL = createOutputFileURL()
        try outputString.write(to: outputURL, atomically: true, encoding: .utf8)
        return outputURL
    }
    
    func createOutputFileURL() -> URL {
        let fileName = logFile.url.lastPathComponent
        let typeSeparatorIndex = fileName.range(of: ".", options: .backwards)!.lowerBound
        let outputFileName = "\(fileName[fileName.startIndex ..< typeSeparatorIndex])_processed\(fileName[typeSeparatorIndex ..< fileName.endIndex])"
        return logFile.url.deletingLastPathComponent().appending(path: outputFileName)
    }
    
    func processFileComponent(_ component: String) -> String {
        let shortened = component
            .withShortenedContainingPaths(to: "/Toolchains/")
            .withShortenedContainingPaths(to: "/DerivedData/")
            .withShortenedContainingPaths(to: "/Platforms/")
            .withShortenedContainingPaths(to: "/Build/")
            .withShortenedContainingPaths(to: "/checkouts/")
            .withShortenedContainingPaths(to: "/Tuist/.build/")
        return shortened.replacingOccurrences(of: " -", with: "\n\t-")
    }
}

extension String {
    func withShortenedContainingPaths(to directoryName: String) -> String {
        components(separatedBy: " ").map { component in
            guard let range = component.range(of: directoryName, options: .backwards) else {
                return component
            }
            return "\(component[range.lowerBound ..< component.endIndex])"
        }
        .joined(separator: " ")
    }
}
