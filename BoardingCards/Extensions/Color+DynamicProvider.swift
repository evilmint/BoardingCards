import SwiftUI

extension Color {
    init(dynamicProvider: @escaping (UITraitCollection) -> UIColor) {
        self.init(UIColor(dynamicProvider: dynamicProvider))
    }
}
