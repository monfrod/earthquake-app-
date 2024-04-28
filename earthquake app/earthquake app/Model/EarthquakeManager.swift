//
//  EarthquakeManager.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//

import Foundation
import UIKit


struct EarthquakeManager {
    let api = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
    
    func fetchEarthquake(){
        
    }
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    do {
                    let decoderData = try JSONDecoder().decode(NewsData.self, from: safeData)
                    completion(decoderData)
                        } catch {
                            print(error)
                        }
                }
            }
            task.resume()
        }
    }
}
