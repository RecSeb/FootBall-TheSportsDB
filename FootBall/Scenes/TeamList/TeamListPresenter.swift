//
//  TeamListPresenter.swift
//  FootBall
//
//  Created by Recep SEBAT on 19/05/2021.
//

import Foundation

class TeamListPresenter {
    private let footballService: FootballService!
    private weak var teamListDelegate: TeamListDelegate!
    
    init(footballService: FootballService, teamListDelegate: TeamListDelegate){
        self.footballService = footballService
        self.teamListDelegate = teamListDelegate
    }
    
    func getLeagues() {
        self.teamListDelegate.startLoading()
        self.footballService.getFootballLeagues() { result in
            switch result {
            case .success(let leagues):
                if leagues.count > 0 {
                    self.teamListDelegate.setLeagues(leaguesName: leagues.map { $0.name })
                }
                self.teamListDelegate.stopLoading()
            case .failure(let error):
                self.teamListDelegate.showError(error: error)
            }
        }
    }
    
    func getTeams(leagueName: String!) {
        self.teamListDelegate.startLoading()
        footballService.getFootballTeams(leagueName: leagueName) { result in
            switch result {
            case .success(let teams):
                self.teamListDelegate.stopLoading()
                if teams.count > 0 {
                    self.teamListDelegate.setTeams(teams: teams)
                }
            case .failure(let error):
                self.teamListDelegate.showError(error: error)
            }
        }
    }
    
    func getTeamDetail(teamName: String!) {
        self.teamListDelegate.startLoading()
        footballService.getTeamDetail(teamName: teamName) { result in
            switch result {
            case .success(let team):
                self.teamListDelegate.stopLoading()
                if let team = team {
                    self.teamListDelegate.setTeamDetail(team: team)
                }
            case .failure(let error):
                self.teamListDelegate.showError(error: error)
            }
        }
    }
}
