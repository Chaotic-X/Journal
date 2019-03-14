//
//  ListTableViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit
import CoreData

class EntryListTableViewController: UITableViewController {
    //MARK: - Propeties
    let fetchedResultsController: NSFetchedResultsController<Entry> = {
        let request: NSFetchRequest<Entry> = Entry.fetchRequest()
        let sorter = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sorter]
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedResultsController.delegate = self
        do{
            try fetchedResultsController.performFetch()
        }catch{
            print("There was an error in \(#function) : \(error).. \(error.localizedDescription)")
        }
    }
    //Fetched results is now taking care of populating and udpating my views
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //
    //        tableView.reloadData()
    //    }
    
    // MARK: UITableViewDataSource/Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Using nill coalescing "??" meaning if nil is returned on fetchedObjects... use the right side of ?? which is 0
        return fetchedResultsController.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entry = fetchedResultsController.fetchedObjects?[indexPath.row]
        cell.textLabel?.text = entry?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let entry = fetchedResultsController.object(at: indexPath)
            EntryController.shared.remove(entry: entry)
            
            // Delete the row from the table view
            //            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toShowEntry" {
            
            if let detailViewController = segue.destination as? EntryDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                let entry = fetchedResultsController.object(at: indexPath)
                detailViewController.entry = entry
            }
        }
    }
}

extension EntryListTableViewController: NSFetchedResultsControllerDelegate {
    //Not great for my umbrella type changes.. so will use something else.
    //    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    //    tableView.reloadData()
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let newIndexPath = indexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            tableView.reloadRows(at: [oldIndexPath, newIndexPath], with: .automatic)
            
        }
    }
}

