//
//  JourneyPlanner+Effect.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 06/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation
import ComposableArchitecture

extension JourneyPlanner {
    func planEffect(using boardingCards: [BoardingCard]) -> Effect<Journey, Never> {
        Effect<Journey, Never>.task(operation: { @MainActor () -> Journey in
           let journey: Journey

           do {
               journey = try await self.plan(using: boardingCards)
           } catch {
               // Errors should be properly handled, left this out for the demo app
               journey = Journey.unplanned(boardingCards: [])
           }

           return journey
       })
    }
}
