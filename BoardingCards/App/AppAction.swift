import Foundation

enum AppAction: Equatable {
    case loading(LoadingAction)
    case result(ResultAction)
    case journeyPlanned(Journey)
}
