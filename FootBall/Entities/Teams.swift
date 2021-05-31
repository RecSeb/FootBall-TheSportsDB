//
//  Teams.swift
//  FootBall
//
//  Created by Recep SEBAT on 27/05/2021.
//

import Foundation

struct Teams: Decodable {
    let array: [Team]
    
    enum CodingKeys: String, CodingKey {
        case array = "teams"
    }
}
