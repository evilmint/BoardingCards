import Foundation

enum AppState: Equatable {
    case result(ResultState)
    case loading(LoadingState)

    public init(journey: Journey) {
        self = .result(.init(journey: journey))
    }

    static func result(journey: Journey) -> Self {
        return .result(.init(journey: journey))
    }
}
