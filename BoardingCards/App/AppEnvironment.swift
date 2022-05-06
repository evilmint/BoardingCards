//
//  AppEnvironment.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct AppEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let journeyPlanner: JourneyPlanner
    let journeyGenerator: JourneyGenerator

    init(
        mainQueue: AnySchedulerOf<DispatchQueue>,
        journeyPlanner: JourneyPlanner,
        journeyGenerator: JourneyGenerator
    ) {
        self.mainQueue = mainQueue
        self.journeyPlanner = journeyPlanner
        self.journeyGenerator = journeyGenerator
    }
}
