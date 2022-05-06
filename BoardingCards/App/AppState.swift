//
//  AppState.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

enum AppState: Equatable {
    case result(ResultState)
    case loading(LoadingState)

    public init(journey: Journey) {
        self = .result(.init(journey: journey))
    }
}
