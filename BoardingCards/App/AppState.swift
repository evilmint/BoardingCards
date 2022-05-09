import Foundation

enum AppState: Equatable {
    case result(ResultState)
    case loading(LoadingState)

    public init(journey: Journey) {
        self = .result(.init(journey: journey, detailsVisible: false, boardingCardDetail: nil))
    }

    static func result(journey: Journey) -> Self {
        return .result(.init(journey: journey, detailsVisible: false, boardingCardDetail: nil))
    }
}
