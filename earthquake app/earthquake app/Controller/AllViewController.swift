//
//  AllViewController.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//

import UIKit

class AllViewController: UIViewController, EarthquakeManagerDelegate  {
    
    func didUpdateEarthquake(earthquake: EarthquakeResponse?) {
        self.earthquakeData = earthquake
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
    }
    

    @IBOutlet weak var tableView: UITableView!
    var earthquakeData: EarthquakeResponse?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        var earthquakeManager = EarthquakeManager()
        earthquakeManager.delegate = self
        earthquakeManager.fetchEartquake()
    }
}
extension AllViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCell", for: indexPath) as! AllTableViewCell
        if let data = earthquakeData?.features[indexPath.row] {
            
            let timestampMilliseconds = data.properties.time
            let timestampSeconds = TimeInterval(timestampMilliseconds) / 1000
            let date = Date(timeIntervalSince1970: timestampSeconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.string(from: date)
            let formattedMagnitude = String(format: "%.2f", data.properties.mag!)
            let geo = data.geometry.coordinates

            
            
            cell.titleLabel.text = data.properties.place
            cell.magnitude.text = formattedMagnitude
            cell.timeLabel.text = formattedDate
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let earthquake = earthquakeData?.features[indexPath.row] else { return }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let mapViewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController else { return }
            
            mapViewController.earthquake = earthquake
            navigationController?.pushViewController(mapViewController, animated: true)
    }
}
