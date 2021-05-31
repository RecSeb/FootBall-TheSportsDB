//
//  Team.swift
//  FootBall
//
//  Created by Recep SEBAT on 19/05/2021.
//

import Foundation

class Team: Decodable {
    let id: String!
    let name: String!
    let badge: String?
    let banner: String?
    let country: String!
    let league: String!
    let description: String!
    
    enum CodingKeys: String, CodingKey {
        case id = "idTeam"
        case name = "strTeam"
        case badge = "strTeamBadge"
        case banner = "strTeamBanner"
        case country = "strCountry"
        case league = "strLeague"
        case description = "strDescriptionEN"
    }
}
