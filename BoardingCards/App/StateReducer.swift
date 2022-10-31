import ComposableArchitecture

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

enum AppAction: Equatable {
    case loading(LoadingAction)
    case result(ResultAction)
    case journeyPlanned(Journey)
}

struct StateReducer: ReducerProtocol {
    typealias State = AppState
    typealias Action = AppAction

    @Dependency(\.journeyPlanner) var journeyPlanner
    @Dependency(\.journeyGenerator) var journeyGenerator

    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .result(.plan(let journey)):
                return .concatenate(
                    Effect(value: .loading(.empty)),
                    journeyPlanner.planEffect(using: journey.boardingCards)
                        .map(AppAction.journeyPlanned)
                )

            case .result(.refresh):
                state = .result(journey: journeyGenerator.generate())
                return .none

            case .loading:
                state = .loading(.init())
                return .none

            case .journeyPlanned(let journey):
                state = .result(journey: journey)
                return .none

            case .result:
                return .none
            }
        }
    }
}

