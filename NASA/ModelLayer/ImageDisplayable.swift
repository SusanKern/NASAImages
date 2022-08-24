//
//  ImageDisplayable.swift
//  NASA
//
//  Created by Susan Kern on 6/5/20.
//  Copyright © 2020 SKern. All rights reserved.
//

/// Protocol describing the actual text that will be displayed to the user
protocol ImageDisplayable {
    var imageTitleLabelText: String { get }
    var imagePhotoLink: String { get }
    var imageDateLabelText: String { get }
    var imageNasaIdLabelText: String { get }
    var imageDescriptionLabelText: String { get }
}
