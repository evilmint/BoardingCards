import SwiftUI

enum BoardingCardsColor {
    static let primary = Color(dynamicProvider: { trait in
        switch trait.userInterfaceStyle {
        case .dark:
            return UIColor(red: 28/255.0, green: 44/255.0, blue: 67/255.0, alpha: 1)
        default:
            return UIColor(red: 57/255.0, green: 88/255.0, blue: 125/255.0, alpha: 1)
        }
    })

    static let background = Color(dynamicProvider: { trait in
        switch trait.userInterfaceStyle {
        case .dark:
            return UIColor(red: 106/255.0, green: 112/255.0, blue: 120/255.0, alpha: 1)
        default:
            return UIColor(red: 212/255.0, green: 225/255.0, blue: 241/255.0, alpha: 1)
        }
    })

    static let text = Color(dynamicProvider: { trait in
        switch trait.userInterfaceStyle {
        case .dark:
            return UIColor.white
        default:
            return UIColor.black
        }
    })

    static let textLightBackground = Color(UIColor.black)
}
