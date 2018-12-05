//
//  ViewController.swift
//  holaMapa
//
//  Created by Usuario invitado on 16/10/18.
//  Copyright © 2018 TitiBass. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mapa: MKMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.startUpdatingLocation()
        mapa.showsUserLocation = true
        
        mapTypeSegmentedControl.addTarget(self, action: #selector(mapTypeChange), for: .valueChanged)
        
        
    }

    @IBAction func addAnotation(_ sender: UIButton) {
        
        let annotation = CoffeeAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: 37.331820, longitude: -122.031180)
        annotation.title = "Algun lugar"
        annotation.subtitle = " de un gran país"
        annotation.imageURL = "coffe-pin.png"
        
        mapa.addAnnotation(annotation)
    }
    
    
    @objc func mapTypeChange( segmentedControl: UISegmentedControl){
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            mapa.mapType = .standard
        case 1:
            mapa.mapType = .satellite
        case 2:
            mapa.mapType = .hybrid
        
        default:
            mapa.mapType = .standard
        }
        
    }
    
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapa.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0009, longitudeDelta: 0.0009))
        mapa.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.first)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        var coffeeAnnotationView = mapa.dequeueReusableAnnotationView(withIdentifier: "CoffeeAnnotationView")
        
        if CoffeeAnnotation == nil{
            coffeeAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "CoffeAnnotationView")
            coffeeAnnotationView?.canShowCallout = true
        } else {
            coffeeAnnotationView?.annotation = annotation
        }
        if let coffeeAnnotation = annotation as ? CoffeeAnnotation do {
            coffeeAnnotationView?.image = UIImage(named: CoffeeAnnotation.imageURL)
        }
    }
}

