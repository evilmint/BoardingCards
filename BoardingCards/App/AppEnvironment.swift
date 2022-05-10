import Foundation
import ComposableArchitecture

struct AppEnvironment {
    let mainQueue: AnySchedulerOf<DispatchQueue>
    let journeyPlanner: JourneyPlanner
    let journeyGenerator: JourneyGenerator
}
