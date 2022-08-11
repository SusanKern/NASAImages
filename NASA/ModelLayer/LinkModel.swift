//
//  LinkModel.swift
//  NASA
//
//  Created by Susan Kern on 8/11/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import Foundation


/// Model object for representing a web link
struct Link: Codable {
    let href: String?

    enum CodingKeys: String, CodingKey {
        case href
    }
}
