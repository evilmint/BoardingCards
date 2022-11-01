import Foundation
import ComposableArchitecture

struct AppReducer: ReducerProtocol {
    enum State: Equatable {
        case result(ResultReducer.State)
        case loading(LoadingState)

        public init(journey: Journey) {
            self = .result(.init(journey: journey, detailsVisible: false, boardingCardDetail: nil))
        }

        static func result(journey: Journey) -> Self {
            return .result(.init(journey: journey, detailsVisible: false, boardingCardDetail: nil))
        }
    }

    enum Action: Equatable {
        case loading(LoadingAction)
        case result(ResultReducer.Action)
        case journeyPlanned(Journey)
    }

    @Dependency(\.journeyPlanner) var journeyPlanner
    @Dependency(\.journeyGenerator) var journeyGenerator

    var body: some ReducerProtocol<State, Action> {
        CombineReducers {
            Reduce { state, action in
                switch action {
                case .result(.plan(let journey)):
                    return .run { send in
                        await send(.loading(.empty))

                        let journey = try await journeyPlanner.plan(using: journey.boardingCards)
                        await send(.journeyPlanned(journey))
                    }

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

            Scope(state: /State.result, action: /Action.result) {
                ResultReducer()
            }
        }
    }
}
