//
//  TeamListController.swift
//
//  Created by Recep SEBAT on 19/05/2021.
//

import UIKit
import SearchTextField
import Kingfisher

class TeamListController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TeamListDelegate {
    
    private let reuseIdentifier = "TeamViewCell"
    private let itemsPerRow: CGFloat = 2
    
    private var teams = [Team]()
    private var selectedTeam: Team?
    private var teamListPresenter: TeamListPresenter!
    
    @IBOutlet weak var searchTextField: SearchTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var retryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamListPresenter = TeamListPresenter(footballService: FootballService(), teamListDelegate: self)
        self.teamListPresenter.getLeagues()
        self.searchTextField.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.searchTextField.text = item.title
            self.teamListPresenter.getTeams(leagueName: item.title)
        }
        self.searchTextField.hideResultsList()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TeamViewCell
        if let badge = self.teams[indexPath.row].badge {
            cell.badgeImageView.kf.setImage(with: URL(string: badge))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfCellsInRow = 2
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfCellsInRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.teamListPresenter.getTeamDetail(teamName: self.teams[indexPath.row].name)
    }
    
    func startLoading() {
        self.loadingIndicator.startAnimating()
        self.loadingView.isHidden = false
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingView.isHidden = true
        }
    }
    
    func setLeagues(leaguesName: [String]) {
        DispatchQueue.main.async {
            self.searchTextField.filterStrings(leaguesName)
        }
    }
    
    func setTeams(teams: [Team]) {
        DispatchQueue.main.async {
            self.teams = teams
            self.collectionView.reloadData()
        }
    }
    
    func setTeamDetail(team: Team) {
        DispatchQueue.main.async {
            self.selectedTeam = team
            self.performSegue(withIdentifier: "showTeamDetail", sender: nil)
        }
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.loadingView.isHidden = true
            self.errorView.isHidden = false
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTeamDetail",
           let detailController = segue.destination as? TeamDetailController {
            detailController.team = self.selectedTeam
        }
    }
    
    @IBAction func retryButtonClicked(_ sender: Any) {
        DispatchQueue.main.async {
            self.errorView.isHidden = true
            self.teamListPresenter.getLeagues()
        }
    }
}
