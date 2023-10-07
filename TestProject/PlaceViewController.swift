//
//  PlaceViewController.swift
//  iwi
//
//  Created by Mansa Pratap Singh on 03/05/22.
//

import UIKit
import GooglePlaces

protocol PlaceViewControllerDelegate {
    func didSelectPlace(place: GMSPlace)
}

class PlaceViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var delegate: PlaceViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        title = "Select Address"//.localizedWithLanguage
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController?.searchBar.placeholder = "please start typing here"
        searchController?.searchBar.tintColor = view.tintColor
        searchController?.searchBar.showsCancelButton = true
        searchController?.delegate = self
        searchController?.searchBar.delegate = self

        let subView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 45.0))
        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        definesPresentationContext = true
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.searchController?.searchBar.becomeFirstResponder()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        dismiss(animated: true)
    }
}

extension PlaceViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place Address: \(String(describing: place.formattedAddress))")
        searchController?.searchBar.text = place.formattedAddress
        delegate?.didSelectPlace(place: place)
        NotificationCenter.default.post(name: UIApplication.willEnterForegroundNotification, object: nil)

        self.dismiss(animated: true, completion: nil)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
