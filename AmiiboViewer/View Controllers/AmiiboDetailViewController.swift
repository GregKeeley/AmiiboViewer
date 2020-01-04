//
//  AmiiboDetailViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/4/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class AmiiboDetailViewController: UIViewController {

    @IBOutlet weak var amiiboImageView: UIImageView!
    @IBOutlet weak var amiiboNameLabel: UILabel!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var gameSeriesLabel: UILabel!
    @IBOutlet weak var amiiboSeriesLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var amiibo: AmiiboElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAmiibo()
    }
    func loadAmiibo() {
        amiiboNameLabel.text = amiibo?.name
        characterNameLabel.text = amiibo?.character
        gameSeriesLabel.text = amiibo?.gameSeries
        amiiboSeriesLabel.text = amiibo?.amiiboSeries
        releaseDateLabel.text = amiibo?.release.na?.description
        amiiboImageView.getImage(with: amiibo!.image) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print("Failed to load image: \(appError)")
                DispatchQueue.main.async {
                    self?.amiiboImageView.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.amiiboImageView.image = image
                }
            }
        }
    }
}
