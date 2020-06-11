//
//  Displayable.swift
//  NASA
//
//  Created by Susan Kern on 6/5/20.
//  Copyright © 2020 SKern. All rights reserved.
//

protocol Displayable {
  var titleLabelText: String { get }
  var photoLink: String { get }
  var dateLabelText: String { get }
  var nasaIdLabelText: String { get }
  var descriptionLabelText: String { get }
}

