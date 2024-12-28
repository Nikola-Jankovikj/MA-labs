//
//  MapViewController.swift
//  Restaurant
//
//  Created by Nikola Jankovikj on 28.12.24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    var targetCoordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupMapView()
        setupLocationManager()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        centerMapOnUserLocation(userLocation)
        
        addUserLocationPin(userLocation)
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user location: \(error.localizedDescription)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let targetCoordinate = targetCoordinate {
            let targetPin = MKPointAnnotation()
            targetPin.coordinate = targetCoordinate
            targetPin.title = "Restaurant"
            mapView.addAnnotation(targetPin)
        }
    }
    
    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func addUserLocationPin(_ userLocation: CLLocation) {
        let userPin = MKPointAnnotation()
        userPin.coordinate = userLocation.coordinate
        userPin.title = "Your Location"
        mapView.addAnnotation(userPin)
    }
    
    private func centerMapOnUserLocation(_ userLocation: CLLocation) {
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
}
