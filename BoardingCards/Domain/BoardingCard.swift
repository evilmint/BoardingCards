import Foundation

final class BoardingCard: Hashable, Equatable, Identifiable {
    let origin: City
    let destination: City

    let transportation: TransportationMeans

    var header: String {
        "\(transportation.name) - \(origin.name) › \(destination.name)"
    }

    init(origin: City, destination: City, transportation: TransportationMeans) {
        self.origin = origin
        self.destination = destination
        self.transportation = transportation
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(origin)
        hasher.combine(destination)
    }

    static func == (lhs: BoardingCard, rhs: BoardingCard) -> Bool {
        lhs.origin == rhs.origin && lhs.destination == rhs.destination
    }
}
