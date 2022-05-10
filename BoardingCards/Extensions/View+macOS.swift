import SwiftUI

extension View {
    func macOS() -> some View {
#if targetEnvironment(macCatalyst)
        self
#else
        self.hidden()
#endif
    }
}
