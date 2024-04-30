//
//  MapViewController.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController, EarthquakeManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        var earthquakeManager = EarthquakeManager()
        earthquakeManager.delegate = self
        earthquakeManager.fetchEartquake(/*completion: */)

    }
    func didUpdateEarthquake(earthquake: EarthquakeResponse?) {
        print(earthquake?.features.first?.properties.mag)
    }
}

