//
//  SWWeatherViewController.swift
//  SmallWeatherApp
//
//  Created by Ivan Tkachenko on 8/26/19.
//  Copyright © 2019 steady. All rights reserved.
//

import UIKit
import CoreData

class SWWeatherViewController: UITableViewController {
    let viewModel = SWWeatherViewModel()
    var fetchedResultController: NSFetchedResultsController<SWCity>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupFetchedResultController()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshDidChange(_:)), for: .valueChanged)
        
        self.refreshControl?.beginRefreshing()
        self.viewModel.loadCitiesData { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    @objc func refreshDidChange(_ refreshControl: UIRefreshControl) {
        self.viewModel.loadCitiesData { [weak self] in
            self?.refreshControl?.endRefreshing()
        }
    }
    
    func setupFetchedResultController() {
        let fetchRequest: NSFetchRequest<SWCity> = SWCity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: NSStringFromSelector(#selector(getter: SWCity.id)), ascending: true)]
        
        self.fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: SWModelManager.shared.model.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        self.fetchedResultController?.delegate = self
        try? self.fetchedResultController?.performFetch()
    }
}

extension SWWeatherViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SWWeatherTableViewCell.tableCellIdentifier, for: indexPath) as! SWWeatherTableViewCell
        let row = indexPath.row
        
        guard let city = self.fetchedResultController?.fetchedObjects?[row] else {
            return cell
        }
        
        cell.cityLabel.text = city.name
        cell.cityWeatherDescription.text = city.weather?.detailDescription
        if let temp = city.info?.celciusTempreture {
            cell.weatherTempreture.text = temp + "º"
        }
        
        cell.weatherImage?.image = city.weather?.image
        city.weather?.downloadIconImage(withContext: SWModelManager.shared.model.viewContext, loadCompletion: {
            DispatchQueue.main.async {
                cell.weatherImage.image = city.weather?.image
            }
        })
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 8
    }
}

extension SWWeatherViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                self.tableView.insertRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                self.tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let newIndexPath = newIndexPath {
                self.tableView.reloadRows(at: [newIndexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                self.tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            print("nothing for row")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
}
