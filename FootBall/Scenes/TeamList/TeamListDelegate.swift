//
//  TeamListDelegate.swift
//  FootBall
//
//  Created by Recep SEBAT on 20/05/2021.
//

import Foundation

protocol TeamListDelegate: class {
    func startLoading()
    func stopLoading()
    func setLeagues(leaguesName: [String])
    func setTeams(teams: [Team])
    func setTeamDetail(team: Team)
    func showError(error: Error)
}
