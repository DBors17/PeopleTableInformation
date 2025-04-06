//
//  WildriftTableViewController.swift
//  WildriftTableInformation
//
//  Created by Bors Dorin on 01.04.2025.
//

import UIKit

class WildriftTableViewController: UITableViewController, UISearchResultsUpdating {
    
    
    //MARK: - model date
    var wildriftData: Wildrift!
    var championData: Champion!
    
    var filteredChampions: [Champion] = []
    var isSearching = false
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make table data
        wildriftData = Wildrift(name: "champions.xml")
        self.title = "Wildrift"
        
        // setup search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search champion..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        filteredChampions = wildriftData.wildriftData
        
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredChampions.count: wildriftData.getCount()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        
        let currentChampion = isSearching ? filteredChampions[indexPath.row] : wildriftData.getChampion(index: indexPath.row)
        // Configer the cell...
        //championData = wildriftData.getChampion(index: indexPath.row)
        
        cell.cellChampionNameLabel?.text = currentChampion.name
        cell.cellChampionDetailsLabel?.text = currentChampion.position
        cell.cellChampionImage?.image = UIImage(named: currentChampion.image)
        
        cell.contentView.layer.cornerRadius = 11
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.1
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.contentView.layer.shadowRadius = 3
        cell.contentView.layer.masksToBounds = true
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.systemGray6
        }else{
            cell.contentView.backgroundColor = UIColor.systemGray5
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        if searchText.isEmpty{
            isSearching = false
        } else {
            isSearching = true
            filteredChampions = wildriftData.wildriftData.filter{
                $0.name.lowercased().contains(searchText) || $0.position.lowercased().contains(searchText)
            }
        }
        
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "seque2")
        {
            let destController = segue.destination as! ViewController
            //get index path from sender
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            championData = isSearching ? filteredChampions[indexPath!.row] : wildriftData.getChampion(index: indexPath!.row)
            
            destController.championData = self.championData
            
        }
    }

}
