//
//  AddNewMarkVC.swift
//  MapsTracking
//
//  Created by Ahmed Nasr on 9/21/20.
//  Copyright © 2020 Ahmed Nasr. All rights reserved.
//

import UIKit
import MapKit

class AddNewMarkVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addNewMarker(gestureRecognizer:)))
        
            
        longPress.minimumPressDuration = 2
        mapView.addGestureRecognizer(longPress)
    }
    
    @objc func addNewMarker(gestureRecognizer: UIGestureRecognizer){
    
        let toutchPoint = gestureRecognizer.location(in: mapView)
        let activeLocation = mapView.convert(toutchPoint, toCoordinateFrom: mapView)
        
        let alert = UIAlertController(title: "Save Place", message: "Put Place that want to save ", preferredStyle: .alert)
        
        alert.addTextField { (txt) in
            txt.placeholder = "put name of place"
        }
        
         let annotation = MKPointAnnotation()

        alert.addAction(UIAlertAction(title: "Save Place", style: .default, handler: { (_) in
            
            annotation.coordinate = activeLocation
            annotation.title = alert.textFields?[0].text
            self.mapView.addAnnotation(annotation)
            
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: activeLocation, span: span)
            self.mapView.setRegion(region, animated: true)
            
        }))
        
        self.present(alert , animated: true , completion: nil)
    }
}
