//
//  AddCatagoryViewController.swift
//  Loyalty
//
//  Created by Alain on 21/11/2018.
//  Copyright © 2018 iOSHetic. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        return nil
    }
}


class AddCatagoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerData: [String] = [String]()
    var pickerIndex: Int = 0

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Catégories"
        
        pickerData = [
            "Vêtement",
            "Automobile",
            "Restauration",
            "Décoration",
            "Marché",
            "Cinéma",
            "Technologie",
            "Musée",
            "École"
        ]
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 16.0)
        self.subtitleLabel.textColor = UIColor(hexString: "#8c8c8cff")
        
        self.categoryPicker.delegate = self
        self.categoryPicker.dataSource = self
        
        self.addButton.layer.cornerRadius = 10
        self.addButton.backgroundColor = UIColor(hexString: "#ff2d55ff")
        self.addButton.titleLabel?.textColor = UIColor(hexString: "#ffffffff")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerIndex = row
    }
    
    @IBAction func addAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Catégorie créée", message: "La catégorie \(pickerData[pickerIndex]) a été créée avec succès.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (action: UIAlertAction!) -> Void in
            
            self.pickerData.remove(at: self.pickerIndex)
            
            if self.pickerData.count == 0 {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.categoryPicker.reloadAllComponents()
            }
        })
        
        self.present(alert, animated: true, completion: nil)
    }
}