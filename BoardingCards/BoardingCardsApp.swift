import ComposableArchitecture
import SwiftUI

@main
struct BoardingCardsApp: App {
    private let journeyGenerator = JourneyGenerator()

    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppReducer.State(journey: journeyGenerator.generate()),
                    reducer: AppReducer()._printChanges()
                )
            )
        }
    }
}
