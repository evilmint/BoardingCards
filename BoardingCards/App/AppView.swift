import ComposableArchitecture
import SwiftUI

struct AppView: View {
    let store: StoreOf<AppReducer>

    init(store: StoreOf<AppReducer>) {
        self.store = store
    }

    public var body: some View {
        SwitchStore(store) {
            CaseLet(state: /AppReducer.State.loading, action: AppReducer.Action.loading) { _ in
                LoadingView()
            }
            CaseLet(state: /AppReducer.State.result, action: AppReducer.Action.result) { store in
                NavigationView {
                    ResultView(store: store)
                        .navigationBarHidden(false)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Trips")
                        .foregroundColor(.black)
                }
                .accentColor(BoardingCardsColor.text)
                .navigationViewStyle(.stack)
            }
        }
    }
}
