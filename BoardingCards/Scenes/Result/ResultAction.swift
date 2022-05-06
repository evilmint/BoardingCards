//
//  ResultAction.swift
//  BoardingCards
//
//  Created by Aleksander Lorenc on 01/05/2022.
//  Copyright © 2022 Aleksander Lorenc. All rights reserved.
//

import Foundation

enum ResultAction: Equatable {
    case sort([BoardingCard])
    case refresh
}
