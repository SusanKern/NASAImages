//
//  Endpoint.swift
//  NASA
//
//  Created by Susan Kern on 8/9/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import Foundation

/// Protocol describing how to be an ReST endpoint
protocol Endpoint {
    
    /// HTTP or HTTPS
    var scheme: String { get }
    
    /// URL such as api.flickr.com
    var baseURL: String { get }
    
    /// specific path to hit this endpoint
    var path: String { get }
    
    /// List of parameters that are necessary for this endpoint, can be empty array
    var params: [URLQueryItem] { get }
    
    /// "GET", "POST"
    var method: String { get }
}
