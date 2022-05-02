import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: Store<AppState, AppAction>

    init(store: Store<AppState, AppAction>) {
        self.store = store
    }

    public var body: some View {
        SwitchStore(self.store) {
            CaseLet(state: /AppState.loading, action: AppAction.loading) { store in
                LoadingView()
            }
            CaseLet(state: /AppState.result, action: AppAction.result) { store in
                NavigationView {
                    ResultView(store: store)
                        .navigationBarHidden(false)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Trips")
                }
                .navigationViewStyle(.stack)
            }
        }
    }
}
