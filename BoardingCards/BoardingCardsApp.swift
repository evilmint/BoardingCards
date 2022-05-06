//
//  BoardingCardsApp.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 02/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

@main
struct BoardingCardsApp: App {
    private let journeyGenerator = JourneyGenerator()

    var body: some Scene {
        WindowGroup {
            AppView(
                store: Store(
                    initialState: AppState(journey: journeyGenerator.generate()),
                    reducer: appReducer.debug(),
                    environment: AppEnvironment(
                        mainQueue: .main,
                        journeyPlanner: JourneyPlanner(),
                        journeyGenerator: journeyGenerator
                    )
                )
            )
        }
    }
}
