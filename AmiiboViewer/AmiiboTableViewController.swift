//
//  ViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/3/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboTableViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var amiibos = [AmiiboElement]() {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        loadAmiibos()
    }
    func loadAmiibos() {
        amiiboAPI.getAllAmiibos { [weak self] result in
            switch result {
            case .failure(let appError):
                print("Failed to load: \(appError)")
            case .success(let data):
                self?.amiibos = data
            }
        }
    }
    
}

extension AmiiboTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        amiibos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "amiiboCell", for: indexPath)
        let amiiboInfo = amiibos[indexPath.row]
        cell.textLabel?.text = amiiboInfo.name
        cell.detailTextLabel?.text = amiiboInfo.release.na?.description
        return cell
    }
}
