//
//  AppReducer.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
        switch action {
        case .result(.sort(let boardingCards)):
            state = .loading(.init())

            return .task(operation: { @MainActor () -> AppAction in
                let sorted: [BoardingCard]

                do {
                    sorted = try await environment.journeyPlanner.plan(using: boardingCards).boardingCards
                } catch {
                    sorted = [] // Errors should be properly handled, left this out for the demo app
                }

                return .updateResults(sorted)
            })

        case .loading:
            break

        case .updateResults(let boardingCards):
            state = .result(
                ResultState(
                    boardingCards: boardingCards,
                    sortingAllowed: false
                )
            )
        }

        return .none
    }
)
.debug()
