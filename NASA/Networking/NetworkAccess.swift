//
//  NetworkAccess.swift
//  NASA
//
//  Created by Susan Kern on 6/10/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import Foundation

let NASA_URL = "https://images-api.nasa.gov/search?"

protocol NetworkAccess {

    func searchImages(for keywords: [String], completion: @escaping(_ items: [Item]?) -> Void)
}
