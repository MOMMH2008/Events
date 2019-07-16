//
//  EventDetailsViewController.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var evenNameLabel: UILabel!
    @IBOutlet weak var evenStartLabel: UILabel!
    @IBOutlet weak var evenImgeView: UIImageView!
    @IBOutlet weak var eventMap: MKMapView!
    
    var eventDetails: ModelEvent!
    override func viewDidLoad() {
        super.viewDidLoad()
        evenNameLabel.text = eventDetails.name
        evenStartLabel.text = eventDetails.startDate
        if let photoUrl = eventDetails.cover {
            evenImgeView.kf.setImage(with: URL(string: photoUrl))
        }
        
        // define the map zoom span
        let latitudZoomLevel : CLLocationDegrees = 0.5
        let longitudZoomLevel : CLLocationDegrees = 0.5
        let zoomSpan:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latitudZoomLevel, longitudeDelta: longitudZoomLevel)
        
        guard let latString = eventDetails.latitude , let longString = eventDetails.longitude else {
            return
        }
        guard let lat = Double(latString) , let long = Double(longString) else {
            return
        }
        
        // use latitud and longitud to create a location coordinate
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
        
        // define and set the region of our map using the zoom map and location
        let region:MKCoordinateRegion = MKCoordinateRegion(center: location, span: zoomSpan)
        eventMap.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = eventDetails.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        eventMap.addAnnotation(annotation)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}
