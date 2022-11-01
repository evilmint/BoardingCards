import Foundation
import Collections
import ComposableArchitecture

final class JourneyPlanner: Sendable {
    func plan(using boardingCards: [BoardingCard]) async throws -> Journey {
        try await Task.sleep(milliseconds: UInt64.random(in: 500 ... 2500))
        return self.planSynchronous(using: boardingCards)
    }

    private func planSynchronous(using boardingCards: [BoardingCard]) -> Journey {
        guard !boardingCards.isEmpty else {
            return Journey.planned(boardingCards: [])
        }

        var destinations: [City: BoardingCard] = [:]

        var cityOccurences: [City: Int] = [:]
        for boardingCard in boardingCards {
            destinations[boardingCard.destination] = boardingCard

            cityOccurences[boardingCard.destination, default: 0] -= 1
            cityOccurences[boardingCard.origin, default: 0] += 1
        }

        let leastVisitedCity = cityOccurences.sorted(by: { $0.value < $1.value }).first!.key

        let terminalDestination = destinations[leastVisitedCity]!
        var lastDestination = terminalDestination

        var sortedBoardingCards: Deque<BoardingCard> = [lastDestination]
        sortedBoardingCards.reserveCapacity(boardingCards.count)

        while true {
            if let boardingCard = destinations[lastDestination.origin] {
                sortedBoardingCards.prepend(boardingCard)
                lastDestination = boardingCard
            } else {
                break
            }
        }

        return Journey.planned(boardingCards: Array(sortedBoardingCards))
    }
}

extension JourneyPlanner: DependencyKey {
  static let liveValue = JourneyPlanner()
}

extension DependencyValues {
  var journeyPlanner: JourneyPlanner {
    get { self[JourneyPlanner.self] }
    set { self[JourneyPlanner.self] = newValue }
  }
}
