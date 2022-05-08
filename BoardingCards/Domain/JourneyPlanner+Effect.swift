import Foundation
import ComposableArchitecture
import Combine

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
