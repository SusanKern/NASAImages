//
//  MasterViewController.swift
//  NASA
//
//  Created by Susan Kern on 6/5/20.
//  Copyright © 2020 SKern. All rights reserved.
//

import UIKit
import Alamofire

import os.signpost

final class MasterViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var items: [Displayable] = []
    private var selectedItem: Displayable?
    private var selectedImage: UIImage?

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
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
        cell.titleLabel?.text = item.titleLabelText
        cell.photoImageView?.image = UIImage(named: "defaultPhoto")
        
        let log = OSLog(subsystem: "com.nasa.app", category: "TablePerformance")
        let signpostID = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: "Load Photo", signpostID: signpostID)

        DispatchQueue.global(qos: .userInitiated).async {
            let imageUrl:URL = URL(string: item.photoLink)!
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            let image = UIImage(data: imageData as Data)
            
            DispatchQueue.main.async {
                cell.photoImageView?.image = image
            }
        }
        
        os_signpost(.end, log: log, name: "Load Photo", signpostID: signpostID)

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
        
        let log = OSLog(subsystem: "com.nasa.app", category: "TablePerformance")
        let signpostID = OSSignpostID(log: log)
        os_signpost(.begin, log: log, name: "Perform Search", signpostID: signpostID)

        let updateItems = { (newItems: [Item]?) in
            if let newItems = newItems {
                self.items = newItems
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        let searchKeywords = criteria.components(separatedBy: " ")  // TODO Add sanitize method for input string
        
        DispatchQueue.global(qos: .userInitiated).async { 
            DataManager.shared.searchImages(for: searchKeywords, completion: updateItems)
        }
        
        os_signpost(.end, log: log, name: "Perform Search", signpostID: signpostID)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        items = [Item]()
        self.tableView.reloadData()
    }
}
