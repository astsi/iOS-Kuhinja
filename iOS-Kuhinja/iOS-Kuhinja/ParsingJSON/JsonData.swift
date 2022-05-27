//
//  JsonData.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 26.5.22..
//

import Foundation

struct CommentsData: Codable {
    
    let feed: [Person]
    
}

struct Person: Codable {

    let id: String
    let profileImageUrl: String
    let comment: String
    var foodPictureUrl: String
    let timestamp: String
}
