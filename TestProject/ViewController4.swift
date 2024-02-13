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
class ViewController4: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate, GMSMapViewDelegate {
    
    
    //to maps work we need to enable google maps in console and get a key and same for places we need to enable google places sdk in console same as for routes we need to enable google directions API in console then only required functionality will work
    
    @IBOutlet weak var destTF: UITextField!
    private var temporaryAddress = AddressModel()
    //for current location
    @IBOutlet weak var gMapView: GMSMapView!
    var startMarker: GMSMarker?
      var endMarker: GMSMarker?
    var polyline: GMSPolyline?
    var line: GMSPolyline? = nil

    var locationManager = CLLocationManager()
    var previousMarker: GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar(with: "Maps Location", isBackNeed: true)
        gMapView.delegate = self
        self.gMapView?.isMyLocationEnabled = true
        
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
          if startMarker == nil {
              // First click: Set the start point
              startMarker = GMSMarker(position: coordinate)
              startMarker?.title = "Start"
              startMarker?.map = mapView
          } else if endMarker == nil {
              // Second click: Set the end point
              endMarker = GMSMarker(position: coordinate)
              endMarker?.title = "End"
              endMarker?.map = mapView

              // Get and display the route
              getDirections()
          } else {
              // If both markers are already set, remove them and place new ones
              startMarker?.map = nil
              endMarker?.map = nil
              polyline?.map = nil
              startMarker = GMSMarker(position: coordinate)
              startMarker?.title = "Start"
              startMarker?.map = mapView
              endMarker = nil
          }
      }
      
     

//       Function to fetch and display the route using the Directions API
//     Function to fetch and display the route using the Directions API
    func getDirections() {

        if let startCoordinate = startMarker?.position, let endCoordinate = endMarker?.position {
            let origin = "\(startCoordinate.latitude),\(startCoordinate.longitude)"
            let destination = "\(endCoordinate.latitude),\(endCoordinate.longitude)"

            let apiKey = "AIzaSyAtJA-OIBFD_7anP50CHgUks5J1qfK25Mg"
            let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(apiKey)"

            // Make an API request to obtain route information
            if let url = URL(string: url) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let routes = json["routes"] as? [[String: Any]], let route = routes.first, let overviewPolyline = route["overview_polyline"] as? [String: Any], let points = overviewPolyline["points"] as? String {
                            // Decode polyline points
                            let path = GMSPath(fromEncodedPath: points)

                            // Create a GMSPolyline and add it to the map
                            self.polyline = GMSPolyline(path: path)
                            self.polyline?.strokeWidth = 3.0
                            self.polyline?.strokeColor = .blue
                            self.polyline?.map = self.gMapView
                        }
                    }
                }
                task.resume()
            }
        }
    }

    
    
    
    
    
//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D)
////    {
////        if startMarker == nil {
////            // First click: Set the start point
////            startMarker = GMSMarker(position: coordinate)
////            startMarker?.title = "Start"
////            startMarker?.map = mapView
////        } else if endMarker == nil {
////            // Second click: Set the end point
////            endMarker = GMSMarker(position: coordinate)
////            endMarker?.title = "End"
////            endMarker?.map = mapView
////
////            // Calculate the distance between start and end points
////            if let startCoordinate = startMarker?.position, let endCoordinate = endMarker?.position {
////                let distance = calculateDistance(startCoordinate, endCoordinate)
////                displayDistance(distance)
////            }
////        }
////    }
//    {
//        if startMarker == nil {
//            // First click: Set the start point
//            startMarker = GMSMarker(position: coordinate)
//            startMarker?.title = "Start"
//            startMarker?.map = mapView
//        } else if endMarker == nil {
//            // Second click: Set the end point
//            endMarker = GMSMarker(position: coordinate)
//            endMarker?.title = "End"
//            endMarker?.map = mapView
//
//            // Draw a line between the start and end points
//            drawLine()
//        } else {
//            // If both markers are already set, remove them and place new ones
//            startMarker?.map = nil
//            endMarker?.map = nil
//            startMarker = GMSMarker(position: coordinate)
//            startMarker?.title = "Start"
//            startMarker?.map = mapView
//            endMarker = nil
//
//            // Remove the existing line
//            line?.map = nil
//        }
//        // Calculate the distance between start and end points
//        if let startCoordinate = startMarker?.position, let endCoordinate = endMarker?.position {
//            let distance = calculateDistance(startCoordinate, endCoordinate)
//            displayDistance(distance)
//        }
//
//
//    }
//
//          func drawLine() {
//              if let startCoordinate = startMarker?.position, let endCoordinate = endMarker?.position {
//                  let path = GMSMutablePath()
//                  path.add(startCoordinate)
//                  path.add(endCoordinate)
//
//                  let polyline = GMSPolyline(path: path)
//                  polyline.strokeWidth = 3.0
//                  polyline.strokeColor = .blue
//                  polyline.map = gMapView
//                  line = polyline
//              }
//          }
    
    func calculateDistance(_ startCoordinate: CLLocationCoordinate2D, _ endCoordinate: CLLocationCoordinate2D) -> CLLocationDistance {
        let startLocation = CLLocation(latitude: startCoordinate.latitude, longitude: startCoordinate.longitude)
        let endLocation = CLLocation(latitude: endCoordinate.latitude, longitude: endCoordinate.longitude)
        return startLocation.distance(from: endLocation)
    }

    func displayDistance(_ distance: CLLocationDistance) {
        // Update the UI to display the distance
        // You can use the UILabel elements you created in the storyboard for this.
        print("the distance is \(distance)")
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
        getDirections()
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

