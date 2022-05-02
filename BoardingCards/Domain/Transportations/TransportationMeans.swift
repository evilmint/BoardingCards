//
//  TransportationType.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

protocol TransportationMeans {
    var instructions: String? { get }
    var name: String { get }
    var boardingCard: BoardingCard? { get set }
}

protocol TransportationMeansInformationFormatter {
    func format() -> String
}
