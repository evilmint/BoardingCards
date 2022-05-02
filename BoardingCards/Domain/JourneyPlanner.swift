import Foundation
import Collections

struct Journey {
    struct Step {
        let description: String
    }

    let boardingCards: [BoardingCard]

    var steps: [Step] {
        var steps: [Step] = []

        for card in boardingCards {
            if let instructions = card.transportation.instructions {
                steps.append(Step(description: instructions))
            }
        }

        steps.append(Step(description: "You have arrived at your final destination."))

        return steps
    }
}

final class JourneyPlanner {
    func plan(using boardingCards: [BoardingCard]) async throws -> Journey {
        let task = Task.detached { () -> Journey in
            try await Task.sleep(nanoseconds: UInt64.random(in: 500_000_000 ... 2_500_000_000))
            return self.planSynchronous(using: boardingCards)
        }
 
        return try await task.value
    }

    private func planSynchronous(using boardingCards: [BoardingCard]) -> Journey {
        guard !boardingCards.isEmpty else {
            return Journey(boardingCards: [])
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

        return Journey(boardingCards: Array(sortedBoardingCards))
    }
}
