import Foundation
import ComposableArchitecture

struct AppReducer: ReducerProtocol {
    var body: some ReducerProtocol<AppState, AppAction> {
        CombineReducers {
            StateReducer()
            Scope(state: /AppState.result, action: /AppAction.result) {
                ResultReducer()
            }
        }
    }
}
