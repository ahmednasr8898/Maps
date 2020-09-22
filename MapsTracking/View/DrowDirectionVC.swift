//
//  DrowDirectionVC.swift
//  MapsTracking
//
//  Created by Ahmed Nasr on 9/21/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DrowDirectionVC: UIViewController , CLLocationManagerDelegate , UISearchBarDelegate , MKMapViewDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManeger = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManeger.delegate = self
        locationManeger.desiredAccuracy = kCLLocationAccuracyBest
        locationManeger.requestAlwaysAuthorization()
        locationManeger.requestWhenInUseAuthorization()
        locationManeger.startUpdatingLocation()
        
        searchBar.delegate = self
        mapView.delegate = self

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
         let centerLocation = locations[0].coordinate
               
               
               let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
               let region = MKCoordinateRegion(center: centerLocation, span: span)
               self.mapView.setRegion(region, animated: true)
               
               
               let annotation = MKPointAnnotation()
               annotation.coordinate = centerLocation
               annotation.title = "My Place"
               mapView.addAnnotation(annotation)
        
    }
    


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchBar.text!) { (placeMarks:[CLPlacemark]?, error:Error?) in
            
            if error != nil{
                print("ERROR FOUNDED")
            }
            else{
                //print(placeMarks?.first?.location?.coordinate)
                let myPlaceMark = (placeMarks![0].location?.coordinate)!
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = myPlaceMark
                annotation.title = self.searchBar.text!
                
                self.mapView.addAnnotation(annotation)
                
                self.mapsDes(destination: myPlaceMark)
            }
        }
    }

    func mapsDes(destination: CLLocationCoordinate2D){
        
        let sourceCore = (locationManeger.location?.coordinate)!
        
        let sourcePlaceMark = MKPlacemark(coordinate: sourceCore)
        let destinationPlaceMark = MKPlacemark(coordinate: destination)
        
        let sourceItem = MKMapItem(placemark: sourcePlaceMark)
        let destnitaionItem = MKMapItem(placemark: destinationPlaceMark)
        
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = sourceItem
        directionRequest.destination = destnitaionItem
        directionRequest.transportType = .automobile
        directionRequest.requestsAlternateRoutes = true
        
        
        let direction = MKDirections(request: directionRequest)
        
        direction.calculate { (response, error) in
            
            if error != nil{
                
                print("ERROR FOUNDED")
            }
            else{
                
                let route = response?.routes[0]
                self.mapView.addOverlay(route!.polyline)
                self.mapView.setVisibleMapRect((route?.polyline.boundingMapRect)! , animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let render = MKPolylineRenderer(overlay: overlay as! MKPolyline)
        render.strokeColor = .blue
        return render
    }
}
