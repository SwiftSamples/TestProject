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
//        if let location = locations.last{
//
//        }

        
        let location = locations.last
        let curLatitude = location?.coordinate.latitude
        let curLongitude = location?.coordinate.longitude
        
        print("current latitude \(curLatitude), longitude: \(curLongitude)")

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
    
//    func getPolylineRoute(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
//
//            let config = URLSessionConfiguration.default
//            let session = URLSession(configuration: config)
//
//            let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=true&mode=driving&key=AIzaSyAneRO7LlfgaFBBH840yIdcKTL5sP866Aw")!
//
//            let task = session.dataTask(with: url, completionHandler: {
//                (data, response, error) in
//
//                print("---> data from JSON: \(String(data: data!, encoding: .utf8))")
//
//                if error != nil {
//                    print(error!.localizedDescription)
//                   // self.activityIndicator.stopAnimating()
//                }
//                else {
//                    do {
//                        if let json : [String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]{
//
//                            guard let routes = json["routes"] as? NSArray else {
//                                DispatchQueue.main.async {
//                                  //  self.activityIndicator.stopAnimating()
//                                }
//                                return
//                            }
//
//                            if (routes.count > 0) {
//                                let overview_polyline = routes[0] as? NSDictionary
//                                let dictPolyline = overview_polyline?["overview_polyline"] as? NSDictionary
//
//                                let points = dictPolyline?.object(forKey: "points") as? String
//
//                                self.showPath(polyStr: points!)
//
//                                DispatchQueue.main.async {
//                                   // self.activityIndicator.stopAnimating()
//
//                                    let bounds = GMSCoordinateBounds(coordinate: source, coordinate: destination)
//                                    let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 170, left: 30, bottom: 30, right: 30))
//                                    self.gMapView!.moveCamera(update)
//                                }
//                            }
//                            else {
//                                DispatchQueue.main.async {
//                                   // self.activityIndicator.stopAnimating()
//                                }
//                            }
//                        }
//                    }
//                    catch {
//                        print("error in JSONSerialization")
//                        DispatchQueue.main.async {
//                           // self.activityIndicator.stopAnimating()
//                        }
//                    }
//                }
//            })
//            task.resume()
//        }

//        func showPath(polyStr :String){
//            let path = GMSPath(fromEncodedPath: polyStr)
//            let polyline = GMSPolyline(path: path)
//            polyline.strokeWidth = 3.0
//            polyline.strokeColor = UIColor.red
//            polyline.map = gMapView // Your map view
//        }
    
    
    @IBAction func dirBtn(_ sender: Any) {
        print("gsajsj \(temporaryAddress.latitude), usahgdui\(temporaryAddress.longitude)")
        
//        let sourceCoordinate = CLLocationCoordinate2D(latitude: 51.5072, longitude: 0.1276)
//        // Replace temporaryAddress with the destination coordinate you want to use
//        let destinationCoordinate = CLLocationCoordinate2D(latitude: temporaryAddress.latitude, longitude: temporaryAddress.longitude)
//
//        getPolylineRoute(from: sourceCoordinate, to: destinationCoordinate)
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







