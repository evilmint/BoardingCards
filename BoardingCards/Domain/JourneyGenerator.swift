import Foundation
import ComposableArchitecture

struct JourneyGenerator {
    func generate(isPlanned: Bool = false) -> Journey {
        if isPlanned {
            return .planned(boardingCards: [
                makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
                makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
                makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
                makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
                makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
            ].shuffled())
        } else {
            return .unplanned(boardingCards: [
                makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
                makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
                makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
                makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
                makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
            ].shuffled())
        }
    }

    private func makeBoardingCard(
        origin: City,
        destination: City,
        transportationType: TransportationMeans? = nil
    ) -> BoardingCard {
        var transportation: TransportationMeans! = transportationType

        if transportation == nil {
            switch Int.random(in: 1...3) {
            case 1:
                transportation = FlightTransportation(
                    traits: FlightTransportation.Traits(
                        seat: randomEntrance(),
                        gate: randomLetter(),
                        flight: randomEntrance(),
                        baggageDropMethod: Bool.random() ? .automatic : .manual(randomEntrance())
                    )
                )
            case 2:
                transportation = BusTransportation(
                    traits: BusTransportation.Traits(type: Bool.random() ? .airport : .regular(randomEntrance()))
                )
            case 3:
                transportation = TrainTransportation(
                    traits: TrainTransportation.Traits(
                        seat: randomEntrance(),
                        train: randomEntrance()
                    )
                )
            default:
                fatalError("Not supported.")
            }
        }

        let boardingCard = BoardingCard(
            origin: origin,
            destination: destination,
            transportation: transportation
        )
        return boardingCard
    }

    private func randomEntrance() -> String {
        let ordinal = Int.random(in: 1...99)
        let letter = randomLetter()
        return String(format: "%02d%@", ordinal, letter)
    }

    private func randomLetter() -> String {
        String(Character(UnicodeScalar(65+Int.random(in: 0...25))!))
    }
}

extension JourneyGenerator: DependencyKey {
  static let liveValue = JourneyGenerator()
}

extension DependencyValues {
  var journeyGenerator: JourneyGenerator {
    get { self[JourneyGenerator.self] }
    set { self[JourneyGenerator.self] = newValue }
  }
}
