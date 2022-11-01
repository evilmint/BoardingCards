import Foundation

protocol TransportationMeans: Sendable {
    func instructions(origin: City, destination: City) -> [AttributedString]
    var name: String { get }
}

protocol TransportationMeansInformationFormatter {
    func format() -> String
}
