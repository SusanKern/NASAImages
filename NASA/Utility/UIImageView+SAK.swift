//
//  UIImageView+SAK.swift
//  NASA
//
//  Created by Susan Kern on 8/24/22.
//  Copyright © 2022 SKern. All rights reserved.
//

import Foundation
import UIKit

/// Simple cache to hold images that have already been downloaded
let imageCache = NSCache<NSString, UIImage>()

/// Request remote images and provide simple cache
/// Adapted from https://www.youtube.com/watch?v=amaHDvilXpE
extension UIImageView {
    @discardableResult  // Don't necessarily have to use the result
    func loadImage(urlString: String, placeholder: UIImage? = nil) -> URLSessionDataTask? {
        // Reset any pre-existing image in the image view
        self.image = nil
        
        // Check for image in existing cache
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return nil
        }
        
        // Validate URL
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        // Assign placeholder to image
        if let placeholderImage = placeholder {
            self.image = placeholderImage
        }
        
        // Set up task that will download and apply the image from the URL
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in 
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                    self.image = downloadedImage
                }
            }
        }
        
        // Kick off the task
        task.resume()
        return task
    }
}
