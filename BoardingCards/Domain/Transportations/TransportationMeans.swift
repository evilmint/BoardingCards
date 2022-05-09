import Foundation

protocol TransportationMeans {
    var instructions: [AttributedString] { get }
    var name: String { get }
    var boardingCard: BoardingCard? { get set }
}

protocol TransportationMeansInformationFormatter {
    func format() -> String
}
