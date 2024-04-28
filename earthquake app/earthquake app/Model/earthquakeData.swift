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
    let mag: Double
    let place: String
    let time: Int
    let updated: Int
    let tz: String?
    let url: String
    let detail: String
    let felt: Int?
    let cdi: Int?
    let mmi: Double?
    let alert: String?
    let status: String
    let tsunami: Int
    let sig: Int
    let net: String
    let code: String
    let ids: String
    let sources: String
    let types: String
    let nst: Int?
    let dmin: Double
    let rms: Double
    let gap: Int
    let magType: String
    let title: String
}

struct Geometry: Decodable {
    let type: String
    let coordinates: [Double]
}

