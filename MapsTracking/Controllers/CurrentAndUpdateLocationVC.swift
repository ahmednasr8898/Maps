//
//  CurrentAndUpdateLocationVC.swift
//  MapsTracking
//
//  Created by Ahmed Nasr on 9/21/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CurrentAndUpdateLocationVC: UIViewController , CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManeger = CLLocationManager()
    
    let annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setUp location Maneger
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestAlwaysAuthorization()
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()
    }
    
    
    // For Update My Current Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let centerLocation = locations[0].coordinate
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: centerLocation, span: span)
        self.mapView.setRegion(region, animated: true)
        
        
        
        annotation.coordinate = centerLocation
        annotation.title = "My Place"
        mapView.addAnnotation(annotation)
        //mapView.removeAnnotation(annotation)
        
    }

}
