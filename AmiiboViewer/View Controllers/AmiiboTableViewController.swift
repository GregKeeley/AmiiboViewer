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
    
    var filterMethod = 1
    var amiibos = [[AmiiboElement]]() {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
 //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        loadAmiibos()
    }
 //MARK: loadAmiibos
    func loadAmiibos() {
        AmiiboAPI.getAllAmiibos { [weak self] result in
            switch result {
            case .failure(let appError):
                print("Failed to load: \(appError)")
            case .success(let data):
                let filteredAmiibos = AmiiboInfo.filterAmiibos(for: self?.filterMethod ?? 0, allAmiibos: data)
                self?.amiibos = filteredAmiibos
            }
        }
    }
  // MARK: prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
       guard let amiiboDetailVC = segue.destination as? AmiiboDetailViewController,
        let indexPath = tableview.indexPathForSelectedRow else {
            fatalError("failed to prepare for segue properly")
            }
            let amiibo = amiibos[indexPath.row]
            amiiboDetailVC.amiibo = amiibo[indexPath.row]
        } else {
           
        }
    }
}
//MARK: Extensions
extension AmiiboTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        amiibos[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "amiiboCell", for: indexPath) as? AmiiboTableViewCell else {
            fatalError("")
        }
        let amiiboInfo = amiibos[indexPath.section]
        cell.configureCell(amiibo: amiiboInfo[indexPath.row])
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return amiibos.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = String()
        switch filterMethod {
            
        case 0:
            title = ("\(amiibos[section].first?.gameSeries ?? "ERROR") : \(amiibos[section].count)")
            
        case 1:
            let year = amiibos[section].first?.release.na?.components(separatedBy: "-")
            title = ("\(year?[0] ?? "N/A") : \(amiibos[section].count)")
        case 2:
            break
        case 3:
            break
        default:
            title = "Amiibos: \(amiibos.count)"
        }
        return title
    }
    
}

extension AmiiboTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
