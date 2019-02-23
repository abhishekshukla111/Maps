//
//  ViewController.swift
//  Maps
//
//  Created by Abhishek Shukla on 2/23/19.
//  Copyright © 2019 Abhishek Shukla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManger = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.startUpdatingLocation()
        checkCoreLocationAccurach()
    }

    func checkCoreLocationAccurach(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManger.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManger.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .restricted{
            print("User has not acception location services")
        }
    }

}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location Mangaer")
    }
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
        
        
        let point = MKPointAnnotation()
        point.coordinate = userLocation.coordinate
        point.subtitle = "i am here"
        
        mapView.addAnnotation(point)
    }
}

