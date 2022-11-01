//
//  ElementPreview.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 12/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import SwiftUI

struct ElementPreview<Value: View>: View {
    private let dynamicTypeSizes: [ContentSizeCategory] = [.extraSmall, .large, .extraExtraExtraLarge]
    private let localizations = Bundle.main.localizations.map(Locale.init).filter { $0.identifier != "base" }

    private let viewToPreview: Value

    init(_ viewToPreview: Value) {
        self.viewToPreview = viewToPreview
    }

    var body: some View {
        Group {
            self.viewToPreview
                .previewLayout(PreviewLayout.sizeThatFits)
                .previewDisplayName("Default preview 1")

            self.viewToPreview
                .previewLayout(PreviewLayout.sizeThatFits)
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode")

            ForEach(localizations, id: \.identifier) { locale in
                self.viewToPreview
                    .previewLayout(PreviewLayout.sizeThatFits)
                    .environment(\.locale, locale)
                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
            }

            ForEach(dynamicTypeSizes, id: \.self) { sizeCategory in
                self.viewToPreview
                    .previewLayout(PreviewLayout.sizeThatFits)
                    .environment(\.sizeCategory, sizeCategory)
                    .previewDisplayName("\(sizeCategory)")
            }
        }
    }
}
