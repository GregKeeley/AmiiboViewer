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
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var backgroundNameLabel: UILabel!

    var nameForBG = ""
    var amiibo: AmiiboElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundNameLabel.isHidden = true
        loadAmiibo()
    }
    func loadAmiibo() {
        let bgName2 = String(repeating: amiibo?.name ?? "Amiibo", count: 50)
        amiiboNameLabel.text = amiibo?.name.uppercased()
        characterNameLabel.text = amiibo?.character
        gameSeriesLabel.text = amiibo?.gameSeries
        
        amiiboSeriesLabel.text = amiibo?.amiiboSeries
        backgroundNameLabel.text = bgName2.uppercased()
        releaseDateLabel.text = amiibo?.release.na?.description
        amiiboImageView.getImage(with: amiibo?.image ?? "") { [weak self] (results) in
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
    @IBAction func viewButtonPressed() {
        if viewButton.backgroundColor == .black {
            
            viewButton.backgroundColor = .clear
                } else {
                    viewButton.backgroundColor = .black
        }
            amiiboNameLabel.isHidden.toggle()
            characterNameLabel.isHidden.toggle()
            gameSeriesLabel.isHidden.toggle()
            amiiboSeriesLabel.isHidden.toggle()
            releaseDateLabel.isHidden.toggle()
            backgroundNameLabel.isHidden.toggle()
        
    }
}
