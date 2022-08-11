//
//  DetailViewController.swift
//  NASA
//
//  Created by Susan Kern on 6/5/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nasaIdLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var descriptionLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    
    var item: ImageDisplayable?
    var image: UIImage?
    
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Initialization
    
    private func commonInit() {
        guard let item = item else { return }

        titleLabel.text = item.imageTitleLabelText
        descriptionTextView.attributedText = NSAttributedString.textFromHTMLString(HTML: item.imageDescriptionLabelText)
        dateLabel.text = item.imageDateLabelText
        nasaIdLabel.text = item.imageNasaIdLabelText
        photoImageView?.image = image
    }
}
