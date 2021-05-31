//
//  FootballServiceTests.swift
//  FootBallTests
//
//  Created by a381146 on 31/05/2021.
//

import XCTest

class FootballServiceTests: XCTestCase {
    
    private var footballService : FootballService!

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testGetFootballLeagues() throws {
        self.givenAFootballService()
        self.whenTheFootballServiceTryToGetLeagues { [unowned self] leagues, footballServiceExpectation in
            self.thenGetTheLeagueList(leagues: leagues, expectation: footballServiceExpectation)
        }
        self.thenTheServiceFinishedToGet()
    }
    
    private func givenAFootballService() {
        self.footballService = FootballService()
    }
    
    private func whenTheFootballServiceTryToGetLeagues(finish: @escaping ([League]?, XCTestExpectation) -> ()) {
        let footballServiceExpectation = expectation(description: "Get Leagues From Server")
        self.footballService.getFootballLeagues { result in
            switch result {
            case .success(let leagues):
                finish(leagues, footballServiceExpectation)
            case .failure(let error):
                XCTFail("FootballService finish() not called: \(error)")
            }
        }
    }
    
    private func thenGetTheLeagueList(leagues: [League]?, expectation: XCTestExpectation) {
        XCTAssertNotNil(leagues)
        XCTAssertTrue(leagues!.count > 0)
        expectation.fulfill()
    }
    
    func testGetFootballTeams() throws {
        self.givenAFootballService()
        self.whenTheFootballServiceTryToGetTeams { [unowned self] teams, footballServiceExpectation in
            self.thenGetTheTeamList(teams: teams, expectation: footballServiceExpectation)
        }
        self.thenTheServiceFinishedToGet()
    }
    
    private func whenTheFootballServiceTryToGetTeams(finish: @escaping ([Team]?, XCTestExpectation) -> ()) {
        let footballServiceExpectation = expectation(description: "Get Teams For Server")
        self.footballService.getFootballTeams(leagueName: "French Ligue 1", completionHandler: { result in
            switch result {
            case .success(let teams):
                finish(teams, footballServiceExpectation)
            case .failure(let error):
                XCTFail("FootballService finish() not called: \(error)")
            }
        })
    }
    
    private func thenGetTheTeamList(teams: [Team]?, expectation: XCTestExpectation) {
        XCTAssertNotNil(teams)
        XCTAssertTrue(teams!.count > 0)
        expectation.fulfill()
    }
    
    func testGetFootballEmptyTeams() throws {
        self.givenAFootballService()
        self.whenTheFootballServiceTryToGetEmptyTeams { [unowned self] teams, footballServiceExpectation in
            self.thenGetTheEmptyTeamList(teams: teams, expectation: footballServiceExpectation)
        }
        self.thenTheServiceFinishedToGet()
    }
    
    private func whenTheFootballServiceTryToGetEmptyTeams(finish: @escaping ([Team]?, XCTestExpectation) -> ()) {
        let footballServiceExpectation = expectation(description: "Get Empty Team for Server")
        self.footballService.getFootballTeams(leagueName: "Ligue", completionHandler: { result in
            switch result {
            case .success(let teams):
                finish(teams, footballServiceExpectation)
            case .failure(let error):
                XCTFail("FootballService finish() not called: \(error)")
            }
        })
    }
    
    private func thenGetTheEmptyTeamList(teams: [Team]?, expectation: XCTestExpectation) {
        XCTAssertNotNil(teams)
        XCTAssertTrue(teams!.count == 0)
        expectation.fulfill()
    }
    
    func testGetFootballTeamDetail() throws {
        self.givenAFootballService()
        self.whenTheFootballServiceTryToGetTeamDetail { [unowned self] team, footballServiceExpectation in
            self.thenGetTheTeamDetail(team: team, expectation: footballServiceExpectation)
        }
        self.thenTheServiceFinishedToGet()
    }
    
    private func whenTheFootballServiceTryToGetTeamDetail(finish: @escaping (Team?, XCTestExpectation) -> ()) {
        let footballServiceExpectation = expectation(description: "Get Empty Team for Server")
        self.footballService.getTeamDetail(teamName: "Paris SG", completionHandler: { result in
            switch result {
            case .success(let team):
                finish(team, footballServiceExpectation)
            case .failure(let error):
                XCTFail("FootballService finish() not called: \(error)")
            }
        })
    }
    
    private func thenGetTheTeamDetail(team: Team?, expectation: XCTestExpectation) {
        XCTAssertNotNil(team)
        XCTAssertTrue(team?.name == "Paris SG")
        expectation.fulfill()
    }

    private func thenTheServiceFinishedToGet() {
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("FootballService finish() not called: \(error)")
            }
        }
    }
}
