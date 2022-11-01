@preconcurrency import ComposableArchitecture
import SwiftUI

extension View {
    func refreshable<State, Action>(store: ViewStore<State, Action>, action: Action) -> some View where Action: Sendable {
#if targetEnvironment(macCatalyst)
        self
#else
        return self.refreshable { store.send(action) }
#endif
    }
}
