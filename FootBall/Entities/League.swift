//
//  League.swift
//  FootBall
//
//  Created by Recep SEBAT on 19/05/2021.
//

import Foundation

class League: Decodable {
    let id: String!
    let name: String!
    let sport: String!
    let alternate: String!
    
    enum CodingKeys: String, CodingKey {
        case id = "idLeague"
        case name = "strLeague"
        case sport = "strSport"
        case alternate = "strLeagueAlternate"
    }
}
