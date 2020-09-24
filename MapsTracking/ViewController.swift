//
//  ViewController.swift
//  MapsTracking
//
//  Created by Ahmed Nasr on 9/21/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       openMapOnPlace()
       addMarkOnPlace()
       
    }
    
    
    // set Region On map
    func openMapOnPlace(){
        
               let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
               let center = CLLocationCoordinate2D(latitude: 30.009346, longitude: 31.201536)
               let region = MKCoordinateRegion(center: center, span: span)
               mapView.setRegion(region, animated: true)
    }
    
    
    // Add Mark at place on Map
    func addMarkOnPlace(){
        
               let annotation = MKPointAnnotation()
               annotation.coordinate = CLLocationCoordinate2D(latitude: 30.009346, longitude: 31.201536)
               annotation.title = "My Place"
               annotation.subtitle = "I'm Here!"
               mapView.addAnnotation(annotation)
    }


}

