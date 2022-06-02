//
//  DAOPlaceDetail.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 29/05/22.
//

import Foundation

// MARK: - DAOPlaceDetail
struct DAOPlaceDetail: Codable {
    let id, alias, name: String?
    let imageURL: String?
    let isClaimed, isClosed: Bool?
    let url: String?
    let phone, displayPhone: String?
    let reviewCount: Int?
    let categories: [DAOPlaceDetailCategory]?
    let rating: Float
    let location: DAOPlaceDetailLocation?
    let coordinates: DAOPlaceDetailCoordinates?
    let photos: [String]?
    let price: String?
    let hours: [DAOPlaceDetailHour]?
    let transactions: [String]?
    let specialHours: [DAOPlaceDetailSpecialHour]?

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClaimed = "is_claimed"
        case isClosed = "is_closed"
        case url, phone
        case displayPhone = "display_phone"
        case reviewCount = "review_count"
        case categories, rating, location, coordinates, photos, price, hours, transactions
        case specialHours = "special_hours"
    }
}

// MARK: - DAOPlaceDetailCategory
struct DAOPlaceDetailCategory: Codable {
    let alias, title: String
}

// MARK: - DAOPlaceDetailCoordinates
struct DAOPlaceDetailCoordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - DAOPlaceDetailHour
struct DAOPlaceDetailHour: Codable {
    let hourOpen: [DAOPlaceDetailOpen]
    let hoursType: String
    let isOpenNow: Bool

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - DAOPlaceDetailOpen
struct DAOPlaceDetailOpen: Codable {
    let isOvernight: Bool
    let start, end: String
    let day: Int

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - DAOPlaceDetailLocation
struct DAOPlaceDetailLocation: Codable {
    let address1, address2, address3, city: String?
    let zipCode, country, state: String
    let displayAddress: [String]
    let crossStreets: String

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}

// MARK: - DAOPlaceDetailSpecialHour
struct DAOPlaceDetailSpecialHour: Codable {
    let date: String
    let isClosed: String?
    let start, end: String
    let isOvernight: Bool

    enum CodingKeys: String, CodingKey {
        case date
        case isClosed = "is_closed"
        case start, end
        case isOvernight = "is_overnight"
    }
}
