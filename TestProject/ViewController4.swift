//
//  ViewController4.swift
//  TestProject
//
//  Created by Swapna Botta on 05/10/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
import MapKit
class ViewController4: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var destTF: UITextField!
    private var temporaryAddress = AddressModel()
    //for current location
    @IBOutlet weak var gMapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var previousMarker: GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar(with: "Maps Location", isBackNeed: true)
        
        self.gMapView?.isMyLocationEnabled = true
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterforeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    //Location Manager delegates---- for current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let location = locations.last
        let curLatitude = location?.coordinate.latitude
        let curLongitude = location?.coordinate.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 6.0)
        self.gMapView?.animate(to: camera)
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()

    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == destTF {
            let vc = PlaceViewController()
            vc.title = "Please type Address"
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    @objc func willEnterforeground(){
                
        let camera = GMSCameraPosition.camera(withLatitude: temporaryAddress.latitude, longitude: temporaryAddress.longitude, zoom: 6.0)
        
        previousMarker?.map = nil
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: temporaryAddress.latitude, longitude: temporaryAddress.longitude)
        marker.title = temporaryAddress.townCity //"Sydney"
        marker.snippet = ""//temporaryAddress.country//"Australia"
        self.gMapView.animate(to: camera)
        previousMarker = marker
        marker.map = gMapView
    }
   
    
    @IBAction func dirBtn(_ sender: Any) {
        print("gsajsj \(temporaryAddress.latitude), usahgdui\(temporaryAddress.longitude)")

    }
    
    
    
}


// MARK: - PlaceViewControllerDelegate
extension ViewController4: PlaceViewControllerDelegate {
    func didSelectPlace(place: GMSPlace) {
        temporaryAddress.addressName = place.formattedAddress ?? ""
        temporaryAddress.latitude = place.coordinate.latitude
        temporaryAddress.longitude = place.coordinate.longitude
        temporaryAddress.addressId = place.placeID ?? ""
                
        print("address: \(place.formattedAddress ?? "")")
        
        place.addressComponents?.forEach{ (addressComponent) in
            addressComponent.types.forEach { (type) in
                switch type {
                case "locality": temporaryAddress.townCity = addressComponent.name
                case "administrative_area_level_2": temporaryAddress.townCity = addressComponent.name
                case "country": temporaryAddress.country = addressComponent.name
                    
                    //                    for countryData in GET_COUNTRIES?.result?.countries ?? [] {
                    //                        if addressComponent.name == countryData.country {
                    //                            temporaryAddress.countryId = String(countryData.countryId ?? 0)
                    //                            temporaryAddress.postCode = ""
                    //                          //  defaultAddress.countryId = String(countryData.countryId ?? 0)
                    //                            // self.getCityService(with: temporaryAddress.countryId)
                    //                        }
                    //                    }
                case "postal_code": temporaryAddress.postCode = addressComponent.name
                default: break
                }
            }
        }
    }
}

// MARK: - AddressModel
struct AddressModel: Codable {
    var addressId = ""
    var addressName = ""
    var country = ""
    var townCity = ""
    var postCode = ""
    var longitude = 0.0
    var latitude = 0.0
    var countryId = ""
}







