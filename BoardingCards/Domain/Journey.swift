import Foundation

struct Journey: Equatable {
    struct Step: Hashable {
        let description: AttributedString
    }

    let isPlanned: Bool
    let boardingCards: [BoardingCard]

    var steps: [Step] {
        var steps = boardingCards
            .flatMap { $0.transportation.instructions }
            .map(Step.init)

        steps.append(Step(description: "You have arrived at your final destination."))
        return steps
    }

    static func planned(boardingCards: [BoardingCard]) -> Self {
        .init(isPlanned: true, boardingCards: boardingCards)
    }

    static func unplanned(boardingCards: [BoardingCard]) -> Self {
        .init(isPlanned: false, boardingCards: boardingCards)
    }
}
