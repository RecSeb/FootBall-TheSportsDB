//
//  Leagues.swift
//  FootBall
//
//  Created by Recep SEBAT on 27/05/2021.
//

import Foundation

struct Leagues: Decodable {
    let array: [League]
    
    enum CodingKeys: String, CodingKey {
        case array = "leagues"
    }
}
