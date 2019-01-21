//
//  User.swift
//  RandomUsers
//
//  Created by  Oleksandra on 1/21/19.
//  Copyright © 2019 sandra-alt. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let gender: String
    let name: Name
    let location: Location
    let email: String
    let dateOfBirth: DateOfBirth
    let phone: String
    let cell: String
    let picture: Picture
    
    private enum CodingKeys: String, CodingKey {
        case gender
        case name
        case location
        case email
        case dateOfBirth = "dob"
        case phone
        case cell
        case picture
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Location: Decodable {
    let city: String
    let state: String
}

struct DateOfBirth: Decodable {
    let date: Date
    let age: Int
}

struct Picture: Decodable {
    let imgURLString: String
    let thumbURLString: String
    
    private enum CodingKeys: String, CodingKey {
        case imgURLString = "large"
        case thumbURLString = "thumbnail"
    }
}
