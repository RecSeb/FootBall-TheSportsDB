//
//  FootballService.swift
//  FootBall
//
//  Created by Recep SEBAT on 19/05/2021.
//

import Foundation

class FootballService {
    
    let leaguesUrl = "https://www.thesportsdb.com/api/v1/json/1/all_leagues.php?"
    let allTeamsUrl = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l="
    let teamUrl = "https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t="
    
    func getFootballLeagues(completionHandler: @escaping (Result<[League], Error>) -> ()) {
        if let leaguesUrl = URL(string: leaguesUrl) {
            URLSession.shared.dataTask(with: leaguesUrl) { (data, response, error) in
                if let error = error {
                    completionHandler(.failure(error))
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200,
                          let leagues = try? JSONDecoder().decode(Leagues.self, from: data) {
                    completionHandler(.success(leagues.array.filter { $0.sport.contains("Soccer") }))
                }
                
            }.resume()
        }
    }
    
    func getFootballTeams(leagueName: String!, completionHandler: @escaping (Result<[Team], Error>) -> ()) {
        if let teamsUrl = URL(string: allTeamsUrl + leagueName.replacingOccurrences(of: " ", with: "%20")) {
            URLSession.shared.dataTask(with: teamsUrl) { (data, response, error) in
                if let error = error {
                    completionHandler(.failure(error))
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                    if let teams = try? JSONDecoder().decode(Teams.self, from: data) {
                        completionHandler(.success(teams.array))
                    } else {
                        completionHandler(.success([Team]()))
                    }
                }
            }.resume()
        }
    }
    
    func getTeamDetail(teamName: String!, completionHandler: @escaping (Result<Team?, Error>) -> ()) {
        if let teamUrl = URL(string: teamUrl + teamName.replacingOccurrences(of: " ", with: "%20")) {
            URLSession.shared.dataTask(with: teamUrl) { (data, response, error) in
                if let error = error {
                    completionHandler(.failure(error))
                } else if let data = data,
                          let response = response as? HTTPURLResponse,
                          response.statusCode == 200 {
                    if let teams = try? JSONDecoder().decode(Teams.self, from: data) {
                        completionHandler(.success(teams.array[0]))
                    } else {
                        completionHandler(.success(nil))
                    }
                }
            }.resume()
        }
    }
}
