//
//  SortByViewController.swift
//  AmiiboViewer
//
//  Created by Gregory Keeley on 1/5/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class SortByViewController: UIViewController {
    @IBOutlet weak var sortPicker: UIPickerView!
    @IBOutlet weak var sortButton: UIButton!
    
    var setFilterMethod = 0
    var sortMethods = ["Game","Year","Amiibo Series","#Aa-Zz"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortButton.layer.cornerRadius = 8
        sortPicker.delegate = self
        sortPicker.dataSource = self
        
    }
    @IBAction func sortPickerButtonPressed() {
        var row = 0

        if let aComponent = sortPicker?.selectedRow(inComponent: 0) {
            row = aComponent
        }
        setFilterMethod = row
        print(setFilterMethod)
    }
}

//MARK: Pickerview Extension
extension SortByViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortMethods[row]
    }
    
}
extension SortByViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        sortMethods.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let aComponent = sortPicker?.selectedRow(inComponent: 0) {
            setFilterMethod = aComponent
        }
    }
}
