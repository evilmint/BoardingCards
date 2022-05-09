import Foundation

struct ResultState: Equatable {
    let journey: Journey!
    let detailsVisible: Bool
    let boardingCardDetail: BoardingCard?

    var sortingAllowed: Bool {
        journey.isPlanned
    }
}
