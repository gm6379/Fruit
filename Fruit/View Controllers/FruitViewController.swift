//
//  FruitViewController.swift
//  Fruit
//
//  Created by George McDonnell on 20/04/2017.
//  Copyright © 2017 George McDonnell. All rights reserved.
//

import UIKit

/**
 Displays a list of fruit types
 */
class FruitViewController: DisplayTimeViewController {
    
    /** The table view in which to display the fruit */
    @IBOutlet private weak var tableView: UITableView!
    
    /** The data source for the fruit table view */
    fileprivate var fruit : [Fruit]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFruitData()
    }
    
    /** Calls the API to fetch the fruit data from the server */
    @IBAction func loadFruitData() {
        API.instance.fetchData { (error, fruit, loadingTime) in
            if let error = error {
                API.instance.updateErrorStats(error: error)
            } else {
                self.fruit = fruit
                self.tableView.reloadData()
                
                API.instance.updateLoadStats(loadingTime: loadingTime)
            }
        }
    }
}

extension FruitViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fruit = self.fruit {
            return fruit.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "FruitTableViewCell")
        
        if let fruitItem = fruit?[indexPath.row] {
            cell.textLabel?.text = fruitItem.type
        }
        return cell
    }
    
}

extension FruitViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let fruitItem = fruit?[indexPath.row] else {
            return
        }
        
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "FruitDetailViewController") as? FruitDetailViewController else {
            return
        }
        
        detailViewController.fruit = fruitItem
        navigationController?.show(detailViewController, sender: nil)
    }
    
}
