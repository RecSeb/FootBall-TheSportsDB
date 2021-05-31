//
//  DetailController.swift
//  FootBall
//
//  Created by Recep SEBAT on 19/05/2021.
//

import UIKit
import Kingfisher

class TeamDetailController: UIViewController, TeamDetailDelegate {
    
    var team: Team?
    private var teamDetailPresenter: TeamDetailPresenter!
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var leagueLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamDetailPresenter = TeamDetailPresenter(teamDetailDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func loadData() {
        if let team = team {
            self.title = team.name
            if let banner = team.banner {
                self.bannerImageView.kf.setImage(with: URL(string: banner))
            }
            self.countryLabel.text = team.country
            self.leagueLabel.text = team.league
            self.descriptionTextView.text = team.description
        }
    }
}
