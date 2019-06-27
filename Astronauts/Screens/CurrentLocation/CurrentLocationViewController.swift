//
//  CurrentLocationViewController.swift
//  astronauts
//
//  Created by Akash kahalkar on 20/06/19.
//  Copyright © 2019 akash. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class CurrentLocationViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var closeButtonOutlet: UIButton!
    
    //MARK: - Properties
    var labelLaunchDate: UILabel!
    var timer = Timer()
    lazy var label: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    lazy var ceo: CLGeocoder = {
     return CLGeocoder()
    }()
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.isHidden = true
        mapView.mapType = .satellite
        mapView.delegate = self
        startTimer()
        createFrontView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer.invalidate()
    }
    
    //MARK: - Helper Methods
    private func createFrontView() {

        //add partial transparentView
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.frame = view.frame
        gradientLayer.locations = [0, 0.3, 1]
        mapView.layer.addSublayer(gradientLayer)
        
        //Title label
        let label = UILabel(frame: CGRect(x: 20, y: 50, width: view.bounds.width - 50, height: 60))
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.text = "Current location of the ISS"
        label.textColor = UIColor.white
        label.textAlignment = .center
        view.addSubview(label)
        
        //Current location label
        labelLaunchDate = UILabel(frame: CGRect(x: 20, y: 80, width: view.bounds.width - 50, height: 60))
        labelLaunchDate.textColor = UIColor.white
        labelLaunchDate.textAlignment = .center
        view.addSubview(labelLaunchDate)
        
        //add close button
        closeButtonOutlet.getFancyButton()
        closeButtonOutlet.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(BaseViewController.closeButtonTapped)))
    }

    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateCraftLocation), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    fileprivate func centerMap(on location: CLLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
        let region = MKCoordinateRegion.init(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    fileprivate func addPinToMap(for location: CLLocation) {
        
        let craftannotaion = CraftAnnotation(coordinate: location.coordinate)
        craftannotaion.coordinate = location.coordinate
        mapView.addAnnotation(craftannotaion)
    }
    
    //MARK: - API calls
    @objc fileprivate func updateCraftLocation() {
        RequestManager.getCurrentLocation {[weak self] (craftLocationResponse) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch craftLocationResponse.result.status {
                case .success:
                    self.removeErrorLabel()
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.mapView.isHidden = false
                    let location = craftLocationResponse.craftLocation.location
                    self.getAddressFromLatLon(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                    self.centerMap(on: location)
                    self.addPinToMap(for: location)
                case .fail:
                    self.addErrorLabel()
                    self.mapView.isHidden = true
                }
            }
        }
    }
    
    private func addErrorLabel() {
        label.isHidden = false
        label.frame = view.frame
        label.center = view.center
        label.textAlignment = .center
        label.text = "No data availabel."
        view.addSubview(label)
    }
    
    private func removeErrorLabel() {
        label.removeFromSuperview()
    }
    
    //MARK: - Reverse Geocoding
    func getAddressFromLatLon(latitude: Double, longitude: Double) {
        
        let reverseGeoCode = RevereseGeocode(latitiude: latitude, longitude: longitude)
        reverseGeoCode.getAddress { (address) in
            DispatchQueue.main.async {
                if let currentLocation = address {
                    self.labelLaunchDate.text = "Currently flying over \(currentLocation)"
                } else {
                    self.labelLaunchDate.text = "NA"
                }
            }
        }
    }
}

//MAR: - MapView Delegates
extension CurrentLocationViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let newAnnotation = annotation as? CraftAnnotation else {return nil}
        let identifier = "craft"
        var view: MKAnnotationView
        
        if let anView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            view = anView
            view.annotation = newAnnotation
        } else {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        view.canShowCallout = false
        view.image = nil
        view.image = #imageLiteral(resourceName: "spcaeCraft")
        return view
    }
}
