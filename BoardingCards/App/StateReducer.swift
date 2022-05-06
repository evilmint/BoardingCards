//
//  StateReducer.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 06/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import ComposableArchitecture

func stateReducer() -> Reducer<AppState, AppAction, AppEnvironment> {
    Reducer { state, action, environment in
        switch action {
        case .result(.sort(let boardingCards)):
            state = .loading(.init())
            return environment.journeyPlanner.planEffect(using: boardingCards)
                .map { .journeyPlanned($0) }

        case .result(.refresh):
            state = .result(.init(journey: environment.journeyGenerator.generate()))
            return .none

        case .loading:
            return .none

        case .journeyPlanned(let journey):
            state = .result(ResultState(journey: journey))
            return .none
        }
    }
}
