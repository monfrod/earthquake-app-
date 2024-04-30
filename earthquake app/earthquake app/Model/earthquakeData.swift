//
//  earthquakeData.swift
//  earthquake app
//
//  Created by yunus on 29.04.2024.
//

import Foundation

struct EarthquakeResponse: Decodable {
    let features: [EarthquakeFeature]
}

struct EarthquakeFeature: Decodable {
    let type: String
    let properties: EarthquakeProperties
    let geometry: Geometry
    let id: String
}

struct EarthquakeProperties: Decodable {
    let mag: Double?
    let place: String
    let time: Double
    let updated: Double
    let tz: String?
    let url: String
    let detail: String
    let felt: Double?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String
    let tsunami: Double
    let sig: Double
    let net: String
    let code: String
    let ids: String
    let sources: String
    let types: String?
    let nst: Double?
    let dmin: Double?
    let rms: Double?
    let gap: Double?
    let magType: String?
    let title: String?
}

struct Geometry: Decodable {
    let type: String
    let coordinates: [Double]
}

