//
//  DetailPresenter.swift
//  FootBall
//
//  Created by Recep SEBAT on 19/05/2021.
//

import Foundation

class TeamDetailPresenter {
    
    private weak var teamDetailDelegate: TeamDetailDelegate!
    
    init(teamDetailDelegate: TeamDetailDelegate) {
        self.teamDetailDelegate = teamDetailDelegate
        self.teamDetailDelegate.loadData()
    }
}
