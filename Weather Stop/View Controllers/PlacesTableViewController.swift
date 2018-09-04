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
    
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Configure View
    private func configureNavigationBar() {
        self.title = "Places"
        
        self.navigationController?.navigationBar.tintColor = AppearanceController.navigationBarTintColor
        let close = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(closeTapped))
        self.navigationItem.leftBarButtonItem = close
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
        let place = PlacesController.shared.places[indexPath.row]
        cell.textLabel?.text = place.name
        cell.accessoryType = place.isSelected ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlace = PlacesController.shared.places[indexPath.row]
        if (!selectedPlace.isDisabled) {
            PlacesController.shared.selectLocation(place: selectedPlace)
            self.dismiss(animated: true)
        }
        
    }
    
}
