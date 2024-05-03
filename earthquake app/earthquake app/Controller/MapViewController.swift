//
//  MapViewController.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//
import CoreLocation
import UIKit
import MapKit

class MapViewController: UIViewController, EarthquakeManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var earthquake: EarthquakeFeature?
    var earthquakeData: EarthquakeResponse?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        var earthquakeManager = EarthquakeManager()
        earthquakeManager.delegate = self
        earthquakeManager.fetchEartquake()
        
        if let earthquake = earthquake {
               let coordinate = CLLocationCoordinate2D(latitude: earthquake.geometry.coordinates[1], longitude: earthquake.geometry.coordinates[0])
               let annotation = MKPointAnnotation()
               annotation.coordinate = coordinate
               mapView.addAnnotation(annotation)
               
               let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
               mapView.setRegion(region, animated: true)
           }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    func didUpdateEarthquake(earthquake: EarthquakeResponse?) {
        self.earthquakeData = earthquake
    }
}
extension MapViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    func render(_ location: CLLocation){
//        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        
//        mapView.setRegion(region, animated: true)
//        
//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinate
//        mapView.addAnnotation(pin)
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            mapView.setRegion(region, animated: true)
            
            if let earthquakeData = self.earthquakeData {
                for feature in earthquakeData.features {
                    let properties = feature.properties
                    let coordinates = feature.geometry.coordinates
                    let magnitude = properties.mag
                    let title = properties.place
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
                    pin.title = title
                    pin.subtitle = "Magnitude: \(magnitude)"
                    mapView.addAnnotation(pin)
                }
            }
    }
}
