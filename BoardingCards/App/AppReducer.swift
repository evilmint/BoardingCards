import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    stateReducer(),
    resultReducer()
        .pullback(state: /AppState.result,
                  action: /AppAction.result,
                  environment: { $0 })
).debug()
