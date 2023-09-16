//
//  Star.swift
//  StarWar
//
//  Created by Chathuranga Adikari on 2023-09-14.
//

import Foundation

// MARK: - Star
struct Star: Codable{
    let count: Int?
    let next, previous: String?
    let results: [Result]?
}

// MARK: - Result
struct Result: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String?
    let climate, gravity, terrain, surfaceWater: String?
    let population: String?
    let residents, films: [String]?
    let created, edited: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}
