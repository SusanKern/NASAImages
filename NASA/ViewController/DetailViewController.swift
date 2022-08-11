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
    @IBOutlet weak var descriptionLabel: UILabel!  // TODO:  change this to a TextView so links will be tappable
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
        
        // Set height constraint on description field to be actual height needed
        //   This allows scrolling to scroll to exactly the right point and no further
        descriptionLabelHeightConstraint.constant = descriptionLabel.frame.height
    }
    
    // MARK: - Initialization
    
    private func commonInit() {
        guard let item = item else { return }

        titleLabel.text = item.imageTitleLabelText
        descriptionLabel.attributedText = NSAttributedString.textFromHTMLString("18px", HTML: item.imageDescriptionLabelText)
        dateLabel.text = item.imageDateLabelText
        nasaIdLabel.text = item.imageNasaIdLabelText
        photoImageView?.image = image
    }
}

// TODO:  Move this out to a general place

extension NSAttributedString {

    // MARK: - Initialization

    convenience init?(HTMLString: String) {
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue] as [NSAttributedString.DocumentReadingOptionKey : Any]
        do {
            try self.init(data: HTMLString.data(using: String.Encoding.utf8)!,
                          options: options,
                          documentAttributes: nil)
        } catch let error as NSError {
            print("\(error.description)")
            return nil
        }
    }


    // MARK: - Helpers

    static func defaultHTMLTextStyle(_ fontSize: String) -> String {
        return """
        <meta charset=\"UTF-8\">
        <style> 
        body { font-family: 'Avenir'; font-size: \(fontSize); } 
        a { font-family: 'Avenir-Medium'; } 
        b { font-family: 'Avenir-Heavy'; text-color: \(UIColor.blue); } 
        strong { font-family: 'Avenir-Heavy'; text-color: \(UIColor.blue); } 
        </style>
        """
    }

    static func textFromHTMLString(_ fontSize: String = "17px", HTML: String) -> NSAttributedString? {
        let styleString = "\(defaultHTMLTextStyle(fontSize))\(HTML)"
        return NSAttributedString(HTMLString: styleString)
    }
}
