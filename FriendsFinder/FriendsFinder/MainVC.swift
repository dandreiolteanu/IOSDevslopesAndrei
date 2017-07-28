//
//  MainVC.swift
//  FriendsFinder
//
//  Created by Mac on 25/07/2017.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase

class MainVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    

    @IBOutlet weak var spotRandomBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    
    var currentLocation: CLLocation!
    let locationManager = CLLocationManager()
    var mapHasCenteredOnce = false
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference!
    var wasChoosed = false
    
    var currentCity = ""
    var currentCountry =  String()
    var currentAddress = String()
    var currentLatitude = String()
    var currentLongitude = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        mapView.delegate = self
        mapView.userTrackingMode = MKUserTrackingMode.follow
        geoFireRef = Database.database().reference()
        geoFire = GeoFire(firebaseRef: geoFireRef)
        
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        }
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            print(String.localizedStringWithFormat("%.2f", self.mapView.userLocation.coordinate.latitude))
            
            self.currentLatitude = String.localizedStringWithFormat("%.2f", self.mapView.userLocation.coordinate.latitude)
            self.currentLatitude = self.currentLatitude.replacingOccurrences(of: ",", with: ".")
            
            self.currentLongitude = String.localizedStringWithFormat("%.2f", self.mapView.userLocation.coordinate.longitude)
            self.currentLongitude = self.currentLongitude.replacingOccurrences(of: ",", with: ".")
            
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Address dictionary
            print(placeMark.addressDictionary as Any)
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                print(locationName)
            }
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                self.currentAddress = street as String!
                print(street)
            }
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                self.currentCity = city as String!
                print(city)
            }
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                print(zip)
            }
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                self.currentCountry = country as String!
                print(country)
                print(self.currentCountry," @@@@@@@@@@@@@@@")
            }
        })

        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        locationAuthStatus()

    }
    
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            mapView.showsUserLocation = true
//            getDetailsForModalVC()
        }

    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, 2000, 2000)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if let loc = userLocation.location {
            
            if !mapHasCenteredOnce {
                centerMapOnLocation(location: loc)
                mapHasCenteredOnce = true
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView: MKAnnotationView!
        let annoId = "Friends"
        
        if annotation.isKind(of: MKUserLocation.self) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "User")
            annotationView.image = UIImage(named: "pinDing")
        } else if let deqAnno = mapView.dequeueReusableAnnotationView(withIdentifier: annoId) {
            
            annotationView = deqAnno
            annotationView?.annotation = annotation
        } else {
            
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: annoId)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView, let anno = annotation as? FriendsAnnotation {
            
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named:"\(anno.friendsNumber)")
            let btn = UIButton()
            btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            btn.setImage(UIImage(named: "designer"), for: .normal)
            annotationView.rightCalloutAccessoryView = btn
        }
        
        return annotationView
    }
    
    func createSighting(forLocation location: CLLocation, withFriends friendsId: Int) {
        
        geoFire.setLocation(location, forKey: "\(friendsId)")
    }
    
    func showSightingsOnMap(location: CLLocation) {
        
        let circleQuerry = geoFire!.query(at: location, withRadius: 2.5)
        _ = circleQuerry?.observe(GFEventType.keyEntered, with: { (key,location) in
            
            if let key = key, let location = location {
                let anno = FriendsAnnotation(coordinate: location.coordinate, friendsNumber: Int(key)!)
                self.mapView.addAnnotation(anno)
            }
        })
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        
        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        showSightingsOnMap(location: loc)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if let anno = view.annotation as? FriendsAnnotation {
            
            let place = MKPlacemark(coordinate: anno.coordinate)
            let destination = MKMapItem(placemark: place)
            destination.name = "Friends location"
            let regionDistance: CLLocationDistance = 1000
            let regionSpan = MKCoordinateRegionMakeWithDistance(anno.coordinate, regionDistance, regionDistance)
            
            let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span), MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking] as [String : Any]
            
            MKMapItem.openMaps(with: [destination], launchOptions: options)
        }
    }
    
    @IBAction func spotRandomFriends(_ sender: Any) {
        
//        let loc = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        
        let nePoint = CGPoint(x: mapView.bounds.origin.x + mapView.bounds.size.width, y: mapView.bounds.origin.y)
        let sePoint = CGPoint(x: mapView.bounds.origin.x, y: mapView.bounds.origin.y + mapView.bounds.size.height)
        
        let neCoord = mapView.convert(nePoint, toCoordinateFrom: mapView)
        let seCoord = mapView.convert(sePoint, toCoordinateFrom: mapView)
        
        let latRange = randomBetweenNumbers(firstNum: Float(neCoord.latitude), secondNum: Float(seCoord.latitude))
        let longRange = randomBetweenNumbers(firstNum: Float(neCoord.longitude), secondNum: Float(seCoord.longitude))
//        let loc = CLLocationCoordinate2D(latitude: CLLocationDegrees(latRange), longitude: CLLocationDegrees(longRange))
        let loc = CLLocation(latitude: CLLocationDegrees(latRange), longitude: CLLocationDegrees(longRange))
        let rand = arc4random_uniform(UInt32(friends.count)) + 1
        print(friends.count)
        print(rand)
        
        createSighting(forLocation: loc, withFriends: Int(rand))
        
    }
    
    
    
    func randomBetweenNumbers(firstNum: Float, secondNum: Float) -> Float{
        return Float(arc4random()) / Float(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    
    
    @IBAction func locateMeBtnPressed(_ sender: Any) {

        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true)
    }
    
//    func getDetailsForModalVC() {
//        
//        let geoCoder = CLGeocoder()
//        let location = CLLocation(latitude: mapView.userLocation.coordinate.latitude, longitude: mapView.userLocation.coordinate.longitude)
//        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
//            print(String.localizedStringWithFormat("%.2f", self.mapView.userLocation.coordinate.latitude))
//            
//            self.currentLatitude = String.localizedStringWithFormat("%.2f", self.mapView.userLocation.coordinate.latitude)
//            self.currentLatitude = self.currentLatitude.replacingOccurrences(of: ",", with: ".")
//            
//            self.currentLongitude = String.localizedStringWithFormat("%.2f", self.mapView.userLocation.coordinate.longitude)
//            self.currentLongitude = self.currentLatitude.replacingOccurrences(of: ",", with: ".")
//            
//            
//            // Place details
//            var placeMark: CLPlacemark!
//            placeMark = placemarks?[0]
//            
//            // Address dictionary
//            print(placeMark.addressDictionary as Any)
//            
//            // Location name
//            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
//                print(locationName)
//            }
//            // Street address
//            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
//                self.currentAddress = street as String!
//                print(street)
//            }
//            // City
//            if let city = placeMark.addressDictionary!["City"] as? NSString {
//                self.currentCity = city as String!
//                print(city)
//            }
//            // Zip code
//            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
//                print(zip)
//            }
//            // Country
//            if let country = placeMark.addressDictionary!["Country"] as? NSString {
//                self.currentCountry = country as String!
//                print(country)
//                print(self.currentCountry," @@@@@@@@@@@@@@@")
//            }
//        })
//
//    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        getDetailsForModalVC()
        
        let modalVC = segue.destination as! ModalVC

        modalVC.currentCity1 = self.currentCity
        modalVC.currentCountry1 = self.currentCountry
        modalVC.currentAddress1 = self.currentAddress
        modalVC.currentLatitude1 = self.currentLatitude
        modalVC.currentLongitude1 = self.currentLongitude
        print("()()()()",modalVC.currentCity1)
    }
    
}
