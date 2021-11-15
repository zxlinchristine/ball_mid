//
//  TableViewController.swift
//  FoodPin
//
//  Created by NDHU_CSIE on 2021/11/1.
//

import UIKit

class TableViewController: UITableViewController {
    
    var ball:[Ball] = []
        
    lazy var dataSource = configureDataSource()

    // MARK: - UITableView Life's Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialized the data source array
        Ball.generateData(sourceArray: &ball) //pass-by-reference

        tableView.dataSource = dataSource
                
        //Create the snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Ball>()
        snapshot.appendSections([.all])
        snapshot.appendItems(ball, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: false)
        
        //configure the navigation title
        navigationController?.navigationBar.prefersLargeTitles = true
    }

  
    // MARK: - UITableView Diffable Data Source

    func configureDataSource() -> DiffableDataSource {
        let cellIdentifier = "datacell"
        
        let dataSource = DiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, restaurant in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
                
                //configure the cell's data
                cell.nameLabel.text = restaurant.name
                cell.thumbnailImageView.image = UIImage(named: restaurant.image)
                cell.accessoryType = restaurant.isFavorite ? .checkmark : .none
                
                return cell
            }
        )
        
        return dataSource
    }
    

 override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) //return the currently slected cell
        cell?.accessoryType = .checkmark
        ball[indexPath.row].isFavorite = true
      
        tableView.deselectRow(at: indexPath, animated: false)  //de-selection
   }
    
    
    // MARK: - UITableView Swipe Actions
    
    //swipe-to-right
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

    // Mark as favorite action
    let actionTitle = ball[indexPath.row].isFavorite ? "dislike" : "like"
        let favoriteAction = UIContextualAction(style: .destructive, title: actionTitle) { (action, sourceView, completionHandler) in

    let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
    //update source array
    self.ball[indexPath.row].isFavorite = self.ball[indexPath.row].isFavorite ? false : true

    //re-generate snapshot and apply again
    var snapshot = NSDiffableDataSourceSnapshot<Section, Ball>()
    snapshot.appendSections([.all])
    snapshot.appendItems(self.ball, toSection: .all)
    self.dataSource.apply(snapshot, animatingDifferences: false)

    //update the cell's accessoryType
    cell.accessoryType = self.ball[indexPath.row].isFavorite ? .checkmark : .none

    // Call completion handler to dismiss the action button
    completionHandler(true)
    }

    // change the background color of the action button
        favoriteAction.backgroundColor = UIColor.systemYellow
        
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])

    return swipeConfiguration
    }
    
    //swipe-to-left
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else {
            return UISwipeActionsConfiguration()
        }
        
        //Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, sourceView, completionHandler) in
          
            
                //delete from the table view (datasource and source array are separated: structure type)
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            //delete from the source array
            self.ball.remove(at: indexPath.row)
            
            // Call completion handler to dismiss the action button
            completionHandler(true)
        }
        
        // Configure the action as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeConfiguration

    }
    
    // MARK: - For Segue's function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //get the destination's view controller
                let destinationController = segue.destination as! DetailViewController
                //pass the data from the source side to the destination side
                destinationController.ballImageName = ball[indexPath.row].image
            }
        }
    }
    @IBOutlet weak var like: UILabel!
    
    
    
}
