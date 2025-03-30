//
//  PeopleTableViewController.swift
//  PeopleTableInformation
//
//  Created by Alexandru Codreanu on 18.03.2025.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    
    
    //MARK: - model date
    var peopleData: People!
    var personData: Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make table data
        peopleData = People(name: "people.xml")
        self.title = "People"
        
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return peopleData.getCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configer the cell...
        personData = peopleData.getPerson(index: indexPath.row)
        cell.textLabel?.text = personData.name
        cell.detailTextLabel?.text = personData.phone
        print(personData.name)
        cell.imageView?.image = UIImage(named: personData.image)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "seque2")
        {
            let destController = segue.destination as! ViewController
            //get index path from sender
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            personData = peopleData.getPerson(index: indexPath!.row)
            
            destController.personData = self.personData
            
        }
    }

}
