import ComposableArchitecture

struct Feature: Reducer {
    enum State {
        case none
        case some
    }
    
    enum Action {
        case doSomething
    }
    
    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}
