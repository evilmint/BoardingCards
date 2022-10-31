import SwiftUI

extension View {
    func macOS() -> some View {
#if targetEnvironment(macCatalyst)
        self
#else
        self.frame(width: 0, height: 0).hidden()
#endif
    }
}
