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
        AmiiboAPI.getAllAmiibos { [weak self] result in
            switch result {
            case .failure(let appError):
                print("Failed to load: \(appError)")
            case .success(let data):
                self?.amiibos = data
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let amiiboDetailVC = segue.destination as? AmiiboDetailViewController,
        let indexPath = tableview.indexPathForSelectedRow else {
            fatalError("failed to prepare for segue properly")
        }
        let amiibo = amiibos[indexPath.row]
        amiiboDetailVC.amiibo = amiibo
    }
}

extension AmiiboTableViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        amiibos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "amiiboCell", for: indexPath) as? AmiiboTableViewCell else {
            fatalError("")
        }
        let amiiboInfo = amiibos[indexPath.row]
        cell.configureCell(amiibo: amiiboInfo)
        return cell
    }
}
