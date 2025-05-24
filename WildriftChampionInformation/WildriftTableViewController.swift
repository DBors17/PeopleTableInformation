import UIKit
import CoreData

class WildriftTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating, CustomCellDelegate {

    // MARK: - Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var frc: NSFetchedResultsController<CDChampion>!

    
    // MARK: - Search
    var filteredChampions: [CDChampion] = []
    var isSearching = false
    let searchController = UISearchController(searchResultsController: nil)

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Wildrift Champions"

        // Add button in navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addChampionTapped))
        
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(showFavorites))
        navigationItem.leftBarButtonItem = favoriteButton

        // Search setup
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search champion..."
        navigationItem.searchController = searchController
        definesPresentationContext = true

        // FRC setup
        frc = NSFetchedResultsController(fetchRequest: makeRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self

        do {
            try frc.performFetch()
            print("Champions fetched:", frc.fetchedObjects?.count ?? 0)
        } catch {
            print("Error fetching champions: \(error)")
        }

        filteredChampions = frc.fetchedObjects ?? []
    }
    
    // MARK: - Add Champion Action
    @objc func addChampionTapped() {
        performSegue(withIdentifier: "showAddChampion", sender: nil)
    }

    @objc func showFavorites() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let favoritesVC = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as? FavoritesViewController {
            navigationController?.pushViewController(favoritesVC, animated: true)
        }
    }
    
    func editButtonTapped(on cell: CustomCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let selectedChampion = isSearching ?
                filteredChampions[indexPath.row] :
                frc.object(at: indexPath)

            performSegue(withIdentifier: "editChampion", sender: selectedChampion)
        }
    }

    func makeRequest() -> NSFetchRequest<CDChampion> {
        let request: NSFetchRequest<CDChampion> = CDChampion.fetchRequest()
        let sorter = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sorter]
        return request
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    func isFavorite(champion: CDChampion) -> Bool {
        let request: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
        request.predicate = NSPredicate(format: "champion == %@", champion)
        
        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch {
            print("Error checking favorite status: \(error)")
            return false
        }
    }


    // MARK: - Search
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            isSearching = false
            tableView.reloadData()
            return
        }

        isSearching = true
        filteredChampions = frc.fetchedObjects?.filter {
            $0.name?.lowercased().contains(searchText) == true ||
            $0.position?.lowercased().contains(searchText) == true
        } ?? []

        tableView.reloadData()
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isSearching ? 1 : frc.sections?.count ?? 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredChampions.count : frc.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedChampion = isSearching ? filteredChampions[indexPath.row] : frc.object(at: indexPath)
        
        print("Selected champion: \(selectedChampion.name ?? "Unknown")")
        
        performSegue(withIdentifier: "seque2", sender: selectedChampion)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }

        let currentChampion = isSearching ?
            filteredChampions[indexPath.row] :
            frc.object(at: indexPath)

        // Configure cell
        cell.cellChampionNameLabel?.text = currentChampion.name
        cell.cellChampionDetailsLabel?.text = currentChampion.position
        cell.cellChampionImage?.image = UIImage(named: currentChampion.image ?? "placeholder")

        // Design
        cell.contentView.layer.cornerRadius = 11
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.1
        cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.contentView.layer.shadowRadius = 3
        cell.contentView.layer.masksToBounds = true
        let isFavoriteChampion = isFavorite(champion: currentChampion)

        if isFavoriteChampion {
            cell.contentView.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.3)
        } else {
            cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.systemGray6 : UIColor.systemGray5
        }


        // set delegate
        cell.delegate = self
        
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seque2" {
            let destController = segue.destination as! ViewController

            if let selectedChampion = sender as? CDChampion {
                destController.championData = selectedChampion
            }
        }

        if segue.identifier == "editChampion" {
            let destinationVC = segue.destination as! AddUpdateChampionViewController

            if let selectedChampion = sender as? CDChampion {
                destinationVC.cManagedObject = selectedChampion
            }
        }
    }
}

