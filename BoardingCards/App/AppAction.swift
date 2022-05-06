//
//  AppAction.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

enum AppAction: Equatable {
    case loading(LoadingAction)
    case result(ResultAction)
    case journeyPlanned(Journey)
}
