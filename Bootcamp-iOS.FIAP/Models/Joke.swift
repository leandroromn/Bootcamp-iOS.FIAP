//
//  Joke.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 27/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

struct Joke: Codable {
    
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "value"
    }
    
}
