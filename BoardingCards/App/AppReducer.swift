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
    stateReducer()
)
    .debug()
