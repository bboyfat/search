//
//  Model.swift
//  TestSearch
//
//  Created by Andrey Petrovskiy on 6/20/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit


struct APIModel: Decodable{
    var total_count: Int
    var items: [Items]
    
}

struct Items: Decodable {
    var name: String
    var owner: Owner
    var html_url: String
    var stargazers_count: Int
}

struct Owner: Decodable {
   
    var avatar_url: String
}
