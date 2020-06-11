//
//  NetworkAccessAFNetworking.swift
//  NASA
//
//  Created by Susan Kern on 6/10/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import Foundation
import Alamofire

class NetworkAccessAFNetworking: NetworkAccess {   
    
    // MARK: - NetworkAccess Protocol
    
    func searchImages(for keywords: [String], completion: @escaping(_ items: [Item]?) -> Void) {
        let combinedKeywords = keywords.joined(separator: "+")
        let parameters: [String: String] = ["keywords": combinedKeywords,  // TODO:  search on keywords field
                                            "media_type" : "image"]

        AF.request(NASA_URL, parameters: parameters)
            .validate()
            .responseDecodable(of: Wrapper.self) { (response) in
                guard let wrapper = response.value else { return }
                
                let collection = wrapper.collection
                if collection.items.count > 0 {
                    print(collection.items[0].links?[0].href ?? "")
                    print(collection.items[0].itemData?[0].title ?? "")
                    print(collection.items[0].itemData?[0].description ?? "")
                }
                
                completion(collection.items)
        }
    }
}
