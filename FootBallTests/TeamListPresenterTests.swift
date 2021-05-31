//
//  TeamListPresenterTests.swift
//  FootBallTests
//
//  Created by Recep SEBAT on 31/05/2021.
//

import XCTest

class TeamListPresenterTests: XCTestCase {
    
    private var footballService: FootballService!
    private var teamListDelegate: TeamListDelegateSpy!
    private var teamListPresenter: TeamListPresenter!

    override func setUpWithError() throws {
        super.setUp()
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testGetLeagues() throws {
        self.givenAFootballService()
        self.givenADelegate()
        self.givenAPresenter()
        self.whenPresenterStartsToGetLeagues()
        self.thenDelegateStartLoading()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for getting leagues")], timeout: 3.0)
        self.thenDelegateTryToGetLeagues()
        self.thenDelegateStopLoading()
    }
    
    func testGetTeams() throws {
        self.givenAFootballService()
        self.givenADelegate()
        self.givenAPresenter()
        self.whenPresenterStartsToGetTeams()
        self.thenDelegateStartLoading()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for getting teams")], timeout: 3.0)
        self.thenDelegateTryToGetTeams()
        self.thenDelegateStopLoading()
    }
    
    func testGetTeamDetail() throws {
        self.givenAFootballService()
        self.givenADelegate()
        self.givenAPresenter()
        self.whenPresenterStartsToGetTeamDetail()
        self.thenDelegateStartLoading()
        _ = XCTWaiter.wait(for: [expectation(description: "Wait for getting team detail")], timeout: 3.0)
        self.thenDelegateTryToGetTeamDetail()
        self.thenDelegateStopLoading()
    }
    
    private func givenAFootballService() {
        self.footballService = FootballService()
    }
    
    private func givenADelegate() {
        self.teamListDelegate = TeamListDelegateSpy()
    }
    
    private func givenAPresenter() {
        self.teamListPresenter = TeamListPresenter(footballService: self.footballService, teamListDelegate: self.teamListDelegate)
    }

    private func whenPresenterStartsToGetLeagues() {
        self.teamListPresenter.getLeagues()
    }
    
    private func whenPresenterStartsToGetTeams() {
        self.teamListPresenter.getTeams(leagueName: "French Ligue 1")
    }
    
    private func whenPresenterStartsToGetTeamDetail() {
        self.teamListPresenter.getTeamDetail(teamName: "Paris SG")
    }
    
    private func thenDelegateStartLoading() {
        XCTAssertTrue(self.teamListDelegate.showStartLoadingHasBeenCalled)
    }
    
    private func thenDelegateStopLoading() {
        XCTAssertTrue(self.teamListDelegate.showStopLoadingHasBeenCalled)
    }
    
    private func thenDelegateTryToGetLeagues() {
        XCTAssertTrue(self.teamListDelegate.getLeaguesHasBeenCalled)
    }
    
    private func thenDelegateTryToGetTeams() {
        XCTAssertTrue(self.teamListDelegate.getTeamsHasBeenCalled)
    }
    
    private func thenDelegateTryToGetTeamDetail() {
        XCTAssertTrue(self.teamListDelegate.getTeamDetailHasBeenCalled)
    }
}

class TeamListDelegateSpy: TeamListDelegate {
    private(set) var showStartLoadingHasBeenCalled: Bool = false
    private(set) var showStopLoadingHasBeenCalled: Bool = false
    private(set) var getLeaguesHasBeenCalled: Bool = false
    private(set) var getTeamsHasBeenCalled: Bool = false
    private(set) var getTeamDetailHasBeenCalled: Bool = false
    private(set) var showError = true
 
    func startLoading() {
        self.showStartLoadingHasBeenCalled = true
    }
    
    func stopLoading() {
        self.showStopLoadingHasBeenCalled = true
    }
    
    func setLeagues(leaguesName: [String]) {
        self.getLeaguesHasBeenCalled = true
    }
    
    func setTeams(teams: [Team]) {
        self.getTeamsHasBeenCalled = true
    }
    
    func setTeamDetail(team: Team) {
        self.getTeamDetailHasBeenCalled = true
    }
    
    func showError(error: Error) {
        
    }
}
