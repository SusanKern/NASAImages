//
//  MasterViewController.swift
//  NASA
//
//  Created by Susan Kern on 6/5/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import UIKit

final class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var items: [ImageDisplayable] = []
    private var selectedItem: ImageDisplayable?
    private var selectedImage: UIImage?

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        // Put image in background of table view
        let imageView = UIImageView(image: UIImage(named: "space"))
        imageView.alpha = 0.2
        imageView.contentMode = .scaleAspectFill
        tableView.backgroundView = imageView
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ImageTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ImageTableViewCell else {
            fatalError("The dequeued cell is not an instance of ImageTableViewCell")
        }
        
        let item = items[indexPath.row]
        cell.titleLabel?.text = item.imageTitleLabelText
        cell.photoImageView?.image = UIImage(named: "defaultPhoto")

        // Go out and get the image from the provided link. Use system-provided global (concurrent) dispatch queue for this.
        // Select "userInitiated" QoS to indicate that this impacts user actively using the app.
        DispatchQueue.global(qos: .userInitiated).async {
            if let imageUrl = URL(string: item.imagePhotoLink),
               let imageData:NSData = NSData(contentsOf: imageUrl),
               let image = UIImage(data: imageData as Data) {
                
                // Switch back to the main dispatch queue for presentation in the UI
                DispatchQueue.main.async {
                    cell.photoImageView?.image = image
                }                
            } 
        }
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedItem = items[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) as? ImageTableViewCell {
            selectedImage = cell.photoImageView.image
        }
        
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? DetailViewController else { return }
        destinationVC.item = selectedItem
        destinationVC.image = selectedImage
    }
}


// MARK: - UISearchBarDelegate

extension MasterViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let criteria = searchBar.text else { return }

        let updateItems = { [weak self] (newItems: [ImageItem]?) in
            if let newItems = newItems {
                self?.items = newItems
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        
        // Find the separate words in the search bar and create an array of them
        let searchKeywords = criteria.components(separatedBy: " ")
        
        DispatchQueue.global(qos: .userInitiated).async { 
            DataAccessManager.shared.searchImages(for: searchKeywords, completion: updateItems)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        self.items = [ImageItem]()
        self.tableView.reloadData()
    }
}
