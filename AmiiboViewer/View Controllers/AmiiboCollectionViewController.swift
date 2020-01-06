//
//  AmiiboCollectionViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/4/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboCollectionViewController: UIViewController {

    @IBOutlet weak var amiiboCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filterMethod = 0
    var sortMethod = 0
    
    var amiibos = [[AmiiboElement]]() {
        didSet {
            DispatchQueue.main.async {
                self.amiiboCollectionView.reloadData()
            }
        }
    }
    
 //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        amiiboCollectionView.dataSource = self
        amiiboCollectionView.delegate = self
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
    
    //MARK: prepareForSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            guard let amiiboDetailVC = segue.destination as? AmiiboDetailViewController,
                let indexPath = amiiboCollectionView.indexPathsForSelectedItems?.first else {
                    fatalError("Failed to prepare for Detail Segue")
            }
            amiiboDetailVC.amiibo = amiibos[indexPath.section][indexPath.row]
        } else if segue.identifier == "collectionToTableViewSegue" {
            guard let amiiboTableView = segue.destination as? AmiiboTableViewController else {
                    fatalError("Failed to prepare for tableViewSegue")
            }
            amiiboTableView.amiibos = amiibos
        }
    }
    
//MARK: Unwind
    @IBAction func unwind(segue: UIStoryboardSegue) {
        loadAmiibos()
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
    }
    
}
//MARK: tableView Extension
extension AmiiboCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        amiibos.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        amiibos[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "amiiboCollectionCell", for: indexPath) as? AmiiboCollectionViewCell
        cell?.contentView.layer.cornerRadius = 8.0
        cell?.contentView.layer.borderWidth = 1.0
        cell!.congifureCell(for: amiibos[indexPath.section][indexPath.row])
        return cell!
    }
    
   
}
//MARK: CollectionViewDelegate
extension AmiiboCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150.0, height: 150.0)
    }
}
extension AmiiboCollectionViewController: UICollectionViewDelegate {
}

//MARK: SearchBar Extension
extension AmiiboCollectionViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        amiibos = AmiiboInfo.searchAmiibos(method: filterMethod, searchQuery: searchBar.text?.lowercased() ?? "mario", allAmiibos: amiibos)
        print(searchText)
    }
    
}
