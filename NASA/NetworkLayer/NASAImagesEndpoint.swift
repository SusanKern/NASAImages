//
//  NASAImagesEndpoint.swift
//  NASA
//
//  Created by Susan Kern on 8/9/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import Foundation

/// Implementation of the endpoint to get NASA images based on a keyword search
enum NASAImagesEndpoint: Endpoint {
    case getSearchResults(searchText: String)

    var scheme: String {
        switch self {
            default:
                return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "images-api.nasa.gov"
        }
    }
    
    var path: String {
        switch self {
        default:
            return "/search"
        }
    }
    
    var params: [URLQueryItem] {
        switch self {
        case .getSearchResults(let searchText):
            return [URLQueryItem(name: "keywords", value: searchText),
                    URLQueryItem(name: "media_type", value: "image")]
        }
    }
    
    var method: String {
        switch self {
        case .getSearchResults:
            return "GET"
        }
    }
}
