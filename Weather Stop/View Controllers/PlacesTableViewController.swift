//
//  PlacesTableViewController.swift
//  Weather Stop
//
//  Created by Austin Blaser on 9/3/18.
//  Copyright © 2018 Austin Blaser. All rights reserved.
//

import UIKit

class PlacesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configureNavigationBar() {
        self.title = "Places"
        
        self.navigationController?.navigationBar.tintColor = AppearanceController.navigationBarTintColor
        let close = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeTapped))
        self.navigationItem.leftBarButtonItem = close
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlacesController.shared.places.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = PlacesController.shared.places[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = PlacesController.shared.places[indexPath.row]
        self.dismiss(animated: true) {
            PlacesController.shared.selectLocation(place: selectedPlace)
        }
    }

}
