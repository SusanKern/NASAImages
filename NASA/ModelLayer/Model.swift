//
//  Model.swift
//  NASA
//
//  Created by Susan Kern on 6/5/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import Foundation


// MARK: - Sample JSON response

/*
success({
    collection =     {
        href = "https://images-api.nasa.gov/search?description=tibet&media_type=image";
        items =         (
        {
            data =                 (
            {
                center = JSC;
                "date_created" = "1973-06-22T00:00:00Z";
                description = "SL2-102-900 (22 June 1973) --- The Great Himalayan Mountain Range, India/Tibet (30.5N, 81.5E) is literally the top of the world where mountains soar to over 20,000 ft. effectively isolating Tibet from the rest of the world. The two lakes seen in the center of the image are the Laga Co and the Kunggyu Co located just inside the Tibet border. Although clouds and rainfall are rare in this region, snow is always present on the mountain peaks. Photo credit: NASA";
                keywords =                         (
                "EARTH OBSERVATIONS (FROM SPACE)",
                INDIA,
                LAKES,
                MOUNTAINS,
                "SKYLAB 2",
                SNOW,
                TIBET
                );
                "media_type" = image;
                "nasa_id" = "sl2-102-900";
                title = "Himalayan Mountain Range, India/Tibet";
            }
            );
            href = "https://images-assets.nasa.gov/image/sl2-102-900/collection.json";
            links =                 (
            {
                href = "https://images-assets.nasa.gov/image/sl2-102-900/sl2-102-900~thumb.jpg";
                rel = preview;
                render = image;
            }
            );
        },
        ...
        );
        metadata =         {
            "total_hits" = 27;
        };
        version = "1.0";
    };
})
*/


// MARK: - Wrapper

struct Wrapper: Codable {
    let collection: Collection
  
    enum CodingKeys: String, CodingKey {
        case collection
    }
}


// MARK: - Collection

struct Collection: Codable {
    let href: String?
    let items: [Item]
    let version: String?
  
    enum CodingKeys: String, CodingKey {
        case href
        case items
        case version    
    }
}


// MARK: - Item

struct Item: Codable {
    let itemData: [ItemData]?
    let links: [Link]?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case itemData = "data"
        case links
        case href
    }
}


// MARK: - ItemData

struct ItemData: Codable {
    let dateCreated: String?
    let description: String?
    let title: String?
    let nasaId: String?
    
    enum CodingKeys: String, CodingKey {
        case dateCreated = "date_created"
        case description
        case title
        case nasaId = "nasa_id"
    }
}


// MARK: - Link

struct Link: Codable {
    let href: String?

    enum CodingKeys: String, CodingKey {
        case href
    }
}


// MARK: - Item: Displayable

extension Item: Displayable {

    var titleLabelText: String {
        if let itemData = itemData?[0], let title = itemData.title {
            return title
        }
        return ""
    }
    
    var photoLink: String {
        if let link = links?[0], let href = link.href {
            return (href)
        }  
        return ""
    }
    
    var dateLabelText: String {
        if let itemData = itemData?[0], let incomingDateString = itemData.dateCreated {
            // TODO: Explain this next section in comments
            if let isoDate = ISO8601DateFormatter().date(from:incomingDateString), 
                let GMT = TimeZone(abbreviation: "GMT") {                
                let prettyDateString = ISO8601DateFormatter.string(from: isoDate, timeZone: GMT, formatOptions: [.withFullDate, .withDashSeparatorInDate])
                return ("Date Taken: \(prettyDateString)")
            } else {
                return ("Date Taken: \(incomingDateString)")
            }
        }
        return ("")
    }
    
    var nasaIdLabelText: String {
        if let itemData = itemData?[0], let nasaId = itemData.nasaId {
            return ("NASA ID: \(nasaId)")
        }
        return ("")
    }
    
    var descriptionLabelText: String {
        if let itemData = itemData?[0], let description = itemData.description {
            return description
        }
        return ""
    }
}
