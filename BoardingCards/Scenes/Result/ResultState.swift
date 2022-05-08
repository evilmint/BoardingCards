import Foundation

struct ResultState: Equatable {
    let journey: Journey

    var sortingAllowed: Bool {
        journey.isPlanned
    }
}
