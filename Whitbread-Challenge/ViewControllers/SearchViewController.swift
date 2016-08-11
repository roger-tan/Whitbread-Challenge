//
//  SearchViewController.swift
//  Whitbread-Challenge
//
//  Created by Roger TAN on 8/10/16.
//  Copyright © 2016 Roger TAN. All rights reserved.
//

import UIKit
import SVProgressHUD
import CoreLocation

class SearchViewController: UIViewController {

    // MARK: - Properties
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    private var viewModel: SearchViewModel = SearchViewModel()
    private var isRequesting: Bool = false
    private var locationManager = CLLocationManager()
    private var previousSearch: String = ""
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLocationManager()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.locationManager.stopUpdatingLocation()
    }

}

// MARK: - Setups

extension SearchViewController {
    
    /**
     Setups the location Manager
     */
    func setupLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch CLLocationManager.authorizationStatus()  {
        case .Restricted, .Denied:
            self.showAlert(NSLocalizedString("Information", comment: ""), message: NSLocalizedString("Please allows the app to use your current location", comment: ""))
            break
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            self.locationManager.requestLocation()
            break
        case .NotDetermined:
            // Do nothing
            break
        }
    }
    
}

// MARK: - Privates

extension SearchViewController {
    
    /**
     Requests for search a venue
     
     - parameter query: name of the venue to search
     */
    private func searchForVenues(query: String) {
        
        guard canExecuteSearch(query) else {
            return
        }
        
        // Verifies the location permission
        switch CLLocationManager.authorizationStatus() {
        case .Restricted, .Denied:
            // Asks users to allows
            self.showAlert(NSLocalizedString("Information", comment: ""), message: NSLocalizedString("Please allows the app to use your current location", comment: ""))
            return
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            break
        case .NotDetermined:
            self.locationManager.requestWhenInUseAuthorization()
            return
        }

        guard let lastLocation = locationManager.location else {
            return
        }

        executeSearch(query, nearLocation: lastLocation)

    }
    
    /**
     Verifies if we can request a search
     
     - parameter query: name to search
     
     - returns: return true if can execute, false if something is wrong
     */
    private func canExecuteSearch(query: String) -> Bool {
        // Avoid the useless request
        guard !isRequesting && query.characters.count > 0 else {
            return false
        }
        
        // Tests accuracy
        guard locationManager.location?.horizontalAccuracy < 100 && locationManager.location?.verticalAccuracy < 100 else {
            return false
        }
        
        // Test if we have already a previous search
        guard previousSearch != query && isRequesting == false else {
            return false
        }
        
        return true
    }
    
    /**
     Executes the query for searching a venue
     
     - parameter query:        query to execute
     - parameter nearLocation: location of user
     */
    private func executeSearch(query: String, nearLocation: CLLocation) {
        isRequesting = true
        
        SVProgressHUD.showWithStatus(NSLocalizedString("Searching...", comment: "Status text for searching a venue"));
        self.previousSearch = query
        viewModel.executeSearch(query, nearLocation: nearLocation) { (venues, error) in
            if error == nil {
                if venues?.count == 0 {
                    SVProgressHUD.showErrorWithStatus(NSLocalizedString("No results", comment: "Status text when there is no results for searching a venue"))
                } else {
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }
            } else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
            }
            self.isRequesting = false
        }
    }
    
    /**
     Shows an alert
     
     - parameter title:   title of the alert
     - parameter message: message of the alert
     */
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK action"), style: .Default, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

// MARK: - Navigation

extension SearchViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.destinationViewController {
        case let detailViewController as VenueDetailViewController:
            guard let sender = sender as? VenueCell else {
                break
            }
            detailViewController.viewModel = sender.viewModel
            break
        default:
            break
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            searchForVenues(searchText)
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension SearchViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        debugPrint("Error in locationManager:didFailWithError : \(error.localizedDescription)")
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            self.locationManager.startUpdatingLocation()
            self.locationManager.requestLocation()
            if let text = searchBar.text {
                self.searchForVenues(text)
            }
        default:
            // Do nothing
            break
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Test if the location accuracy is under 100 meters
        guard manager.location?.horizontalAccuracy < 100 && manager.location?.verticalAccuracy < 100 else {
            return
        }
        
        if let text = searchBar.text {
            self.searchForVenues(text)
        }
    }
    
}

// MARK: - UITableViewDataSource

extension SearchViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.previousResults.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("VenueCell") as? VenueCell {
            let venueViewModel = viewModel.previousResults[indexPath.row]
            cell.viewModel = venueViewModel
            return cell
        }
        return UITableViewCell()
    }
    
}
