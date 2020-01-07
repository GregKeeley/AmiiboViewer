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
    
    var filterMethod = 1
    
    
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
            
            guard segue.destination is AmiiboTableViewController else {
                    fatalError("Failed to prepare for tableViewSegue")
            }
        }
    }
    //MARK: CollectionReuableView
    func collectionView(_ amiiboCollection: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = amiiboCollection.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "sectionLabel", for: indexPath) as? SectionHeader {
            switch filterMethod {
            case 0:
                sectionHeader.sectionHeaderlabel.text = ("\(amiibos[indexPath.section].first?.gameSeries ?? "ERROR") : \(amiibos[indexPath.section].count)")
            case 1:

                let year = amiibos[indexPath.section].first?.release.na?.components(separatedBy: "-")
                sectionHeader.sectionHeaderlabel.text = ("\(year?[0] ?? "N/A") : \(amiibos[indexPath.section].count)")
            case 2:
                break
            case 3:
                break
            default:
                title = "Amiibos: \(amiibos.count)"
            }
            return sectionHeader
        }
        return UICollectionReusableView()
    }
//MARK: IBActions (UnwindSegue)
    @IBAction func unwind(segue: UIStoryboardSegue) {
        guard let sortByController = segue.source as? SortByViewController else {
            fatalError("Failed to unwind properly from sortByController")
        }
        self.filterMethod = sortByController.setFilterMethod
        loadAmiibos()
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        searchBar.resignFirstResponder()
    }
    
}
//MARK: CollectionView Extension
extension AmiiboCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {


       return amiibos.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return amiibos[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "amiiboCollectionCell", for: indexPath) as? AmiiboCollectionViewCell
        cell!.congifureCell(for: amiibos[indexPath.section][indexPath.row])
        cell?.amiiboImageView.layer.masksToBounds = true
        cell?.amiiboImageView.layer.cornerRadius = 8.0
        cell?.contentView.layer.cornerRadius = 8.0
        cell?.contentView.layer.borderWidth = 2.0
        return cell!
    }
    
    
}
//MARK: CollectionViewDelegate
extension AmiiboCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat((amiiboCollectionView.frame.size.width / 3) - 10), height: CGFloat(100))
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
        
    }
    
}
