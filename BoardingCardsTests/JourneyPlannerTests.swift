import XCTest
@testable import BoardingCards

final class JourneyPlannerTests: XCTestCase {
    private var sut: JourneyPlanner!

    override func setUp() {
        super.setUp()
        sut = JourneyPlanner()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_plan_shouldSortBoardingCards() async throws {
        // Given
        let cards = [
            makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
            makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
            makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
            makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
            makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
        ]

        // When
        let journey = try await sut.plan(using: cards)

        // Then
        XCTAssertEqual(journey.boardingCards, [
            makeBoardingCard(origin: City(name: "Tokyo"), destination: City(name: "Warsaw")),
            makeBoardingCard(origin: City(name: "Warsaw"), destination: City(name: "Prague")),
            makeBoardingCard(origin: City(name: "Prague"), destination: City(name: "Budapest")),
            makeBoardingCard(origin: City(name: "Budapest"), destination: City(name: "Berlin")),
            makeBoardingCard(origin: City(name: "Berlin"), destination: City(name: "Vienna"))
        ])
    }

    func test_plan_shouldReturnJourneyInstructions() async throws {
        // Given
        let cards = [
            makeBoardingCard(
                origin: City(name: "Tokyo"),
                destination: City(name: "Warsaw"),
                transportationType: FlightTransportation(
                    traits: .init(seat: "4A", gate: "190", flight: "445NE", baggageDropMethod: .automatic)
                )
            ),
            makeBoardingCard(
                origin: City(name: "Warsaw"),
                destination: City(name: "Prague"),
                transportationType: BusTransportation(traits: .init(type: .airport))
            ),
            makeBoardingCard(
                origin: City(name: "Prague"),
                destination: City(name: "Budapest"),
                transportationType: FlightTransportation(
                    traits: .init(seat: "198C", gate: "39", flight: "TP1", baggageDropMethod: .manual("DS491"))
                )
            )
        ]

        // When
        let journey = try await sut.plan(using: cards)

        // Then
        let steps = journey.steps
        XCTAssertEqual(steps.count, 3 + 1) // 3 + final destination arrival

        XCTAssertEqual(steps[0].description, "From Tokyo, take flight 445NE to Warsaw. Gate 190, seat 4A. Baggage will we automatically transferred from your last leg.")
        XCTAssertEqual(steps[1].description, "Take the airport bus from Warsaw to Prague. No seat assignment.")
        XCTAssertEqual(steps[2].description, "From Prague, take flight TP1 to Budapest. Gate 39, seat 198C. Baggage drop at ticket counter DS491.")
        XCTAssertEqual(steps[3].description, "You have arrived at your final destination.")
    }

    private func makeBoardingCard(
        origin: City,
        destination: City,
        transportationType: TransportationMeans? = nil
    ) -> BoardingCard {
        var transportation: TransportationMeans = transportationType ?? FlightTransportation(
            traits: FlightTransportation.Traits(
                seat: "45B",
                gate: "A",
                flight: "BER45",
                baggageDropMethod: .automatic
            )
        )

        let boardingCard = BoardingCard(
            origin: origin,
            destination: destination,
            transportation: transportation
        )
        transportation.boardingCard = boardingCard
        return boardingCard
    }
}
