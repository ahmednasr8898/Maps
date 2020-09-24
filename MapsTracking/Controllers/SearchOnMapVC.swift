//
//  SearchOnMapVC.swift
//  MapsTracking
//
//  Created by Ahmed Nasr on 9/21/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//

import UIKit
import MapKit

class SearchOnMapVC: UIViewController  , UISearchBarDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        searchBar.delegate = self
    }
    
    //Way One Using Geocoder
    
    /*func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchBar.text!) { (markPlaces: [CLPlacemark]?, error:Error?)
            in
            
            let placeMyMark = markPlaces?.first
            
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = (placeMyMark?.location?.coordinate)!
            annotaion.title = searchBar.text!
            
            self.mapView.addAnnotation(annotaion)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: (placeMyMark?.location?.coordinate)!, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }*/
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text!
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            if error != nil{
                
                print("ERROR FOUNDED \(error!.localizedDescription)")
            }
            else{
                
                for item in response!.mapItems{
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.placemark.title
                    self.mapView.addAnnotation(annotation)
                }
                
                self.mapView.setRegion(response!.boundingRegion, animated: true)
                
            }
            
            
        }
        
    }
    


}
