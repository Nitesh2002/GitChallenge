//
//  InfoModel.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import Foundation

typealias Information = Info

struct Info : Codable {
    var title : String?
    var rows : [Row]?
}

struct Row: Codable {
    var title : String?
    var description : String?
    var imageHref: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case imageHref = "imageHref"
    }
}
