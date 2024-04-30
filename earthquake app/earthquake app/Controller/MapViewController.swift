//
//  MapViewController.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let earthquakeManager = EarthquakeManager()

        earthquakeManager.fetchEartquake { response in
            // Здесь вы можете обрабатывать данные из ответа
            // Например, вы можете напечатать информацию о первом землетрясении в массиве features:
            if let firstEarthquake = response.features.first {
                print("Магнитуда: \(firstEarthquake.properties.mag)")
                print("Место: \(firstEarthquake.properties.place)")
                print("Время: \(firstEarthquake.properties.time)")
            }
        }
    }

}
