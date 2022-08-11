//
//  DataManager.swift
//  NASA
//
//  Created by Susan Kern on 6/10/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import Foundation

/**
 DataManager is using the "Facade" design pattern.  It is hiding the complexity of managing the data include the network access to get the
 data from the API.  From the outside, the user only sees the interface.
 
 DataManager is also using the "Singleton" design pattern.  It is a shared resource, and there can only ever be one of them instantiated in the system.
 */
final class DataManager {
    
    // MARK: - Singleton access
    
    static let shared = DataManager()
    
    
    // MARK: - Initialization
    
    private init() {
    }
    
    
    // MARK: - Public methods
    
    func searchImages(for keywords: [String], completion: @escaping(_ items: [ImageItem]?) -> Void) {
        //networkAccess.searchImages(for: keywords, completion: completion)
        
        let combinedKeywords = keywords.joined(separator: "+")
        
        NetworkEngine.request(endpoint: NASAImagesEndpoint.getSearchResults(searchText: combinedKeywords)) { (result: Result<ImageResponseWrapper?, Error>) in
            switch result {
            case .success(let response):
                //print("Response: \(response)")
                if let collection = response?.imageCollection {
                    if collection.imageItems.count > 0 {
                        print(collection.imageItems[0].links?[0].href ?? "")
                        print(collection.imageItems[0].itemData?[0].title ?? "")
                        print(collection.imageItems[0].itemData?[0].description ?? "")
                    }
                    
                    completion(collection.imageItems)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
