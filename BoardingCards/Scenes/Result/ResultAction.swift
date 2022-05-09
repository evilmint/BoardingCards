import Foundation

enum ResultAction: Equatable {
    case plan(Journey)
    case refresh
    case presentDetails(Bool, BoardingCard?)
    case detailsDismissed
}
