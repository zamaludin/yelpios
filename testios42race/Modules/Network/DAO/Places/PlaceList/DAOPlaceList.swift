//
//  DAOPlaceList.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 29/05/22.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dAOPlaceList = try? newJSONDecoder().decode(DAOPlaceList.self, from: jsonData)

import Foundation

// MARK: - DAOPlaceList
struct DAOPlaceList: Codable {
    let total: Int
    let businesses: [DAOPlaceListBusiness]
    let region: DAOPlaceListRegion
}

// MARK: - Business
struct DAOPlaceListBusiness: Codable {
    let rating: Double
    let price, phone, id, alias: String?
    let isClosed: Bool
    let categories: [DAOPlaceListCategory]
    let reviewCount: Int
    let name: String
    let url: String
    let coordinates: DAOPlaceListCenter
    let imageURL: String
    let location: DAOPlaceListLocation
    let distance: Double
    let transactions: [String]

    enum CodingKeys: String, CodingKey {
        case rating, price, phone, id, alias
        case isClosed = "is_closed"
        case categories
        case reviewCount = "review_count"
        case name, url, coordinates
        case imageURL = "image_url"
        case location, distance, transactions
    }
}

// MARK: - Category
struct DAOPlaceListCategory: Codable {
    let alias, title: String
}

// MARK: - Center
struct DAOPlaceListCenter: Codable {
    let latitude, longitude: Double
}

// MARK: - Location
struct DAOPlaceListLocation: Codable {
    let city, country, address2, address3: String?
    let state, address1, zipCode: String

    enum CodingKeys: String, CodingKey {
        case city, country, address2, address3, state, address1
        case zipCode = "zip_code"
    }
}

// MARK: - Region
struct DAOPlaceListRegion: Codable {
    let center: DAOPlaceListCenter
}
