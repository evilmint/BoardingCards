//
//  ResultState.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 06/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

struct ResultState: Equatable {
    let journey: Journey

    var sortingAllowed: Bool {
        journey.isPlanned
    }
}
