import Foundation

protocol TransportationMeans {
    var instructions: String? { get }
    var name: String { get }
    var boardingCard: BoardingCard? { get set }
}

protocol TransportationMeansInformationFormatter {
    func format() -> String
}
