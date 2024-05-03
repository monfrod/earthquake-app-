//
//  EarthquakeManager.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//

import Foundation
import UIKit

protocol EarthquakeManagerDelegate {
    func didUpdateEarthquake(earthquake: EarthquakeResponse?)
}

struct EarthquakeManager {
    
    typealias CompletionHandler = (EarthquakeResponse) -> Void
    var delegate: EarthquakeManagerDelegate?
    let api = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson"
    
    func fetchEartquake(){
        performRequest(urlString: api)
    }
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data{
                    if let earthquake = self.parseJSON(earthquakeData: safeData){
                        self.delegate?.didUpdateEarthquake(earthquake: earthquake)
                    }
                }
            }
            task.resume()
        }
    }
    func parseJSON(earthquakeData: Data) -> EarthquakeResponse?{
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(EarthquakeResponse.self, from: earthquakeData)
            return decoderData
        } catch {
            print(error)
            return nil
        }
    }
}

