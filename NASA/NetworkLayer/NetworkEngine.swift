//
//  NetworkEngine.swift
//  NASA
//
//  Created by Susan Kern on 8/9/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import Foundation

class NetworkEngine {
    
    /// Executes the web call and decode the JSON response into the Codable object provided
    /// - Parameters:
    ///     - endpoint: the endpoint to make the HTTP request against
    ///     - completion: the JSON response converted to the provided Codable object if successful, or failure otherwise
    
    class func request<T: Codable>(endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) {
        
        // Assemble URL from endpoint components
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.params
        
        // Make sure URL was constructed without issue
        guard let url = components.url else {
            print("Failed to provide valid URL")
            return
        }
        
        // Create the request and specify the HTTP method
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        // Create the URL session with the created URL request
        let session = URLSession(configuration: .default)
        
        // Create the data task which handles getting data correctly, getting HTTP response and handles error
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            
            guard response != nil, let data = data else { return }
            
            DispatchQueue.main.async {
                // Convert data from response into expected codable object
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    // In case of failure, create error definition to pass back
                    let error = NSError(domain:"", code: 200, userInfo: [NSLocalizedDescriptionKey: "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        }
        
        // Trigger the request
        dataTask.resume()
    }
}
