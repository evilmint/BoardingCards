import Foundation

protocol TransportationMeans: Sendable {
    func instructions(origin: City, destination: City) throws -> [AttributedString]
    var name: String { get }
}

protocol TransportationMeansInformationFormatter {
    func format() -> String
}
