//
//  addManualViewController.swift
//  producto
//
//  Created by macbook on 11/26/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class addManualViewController: UIViewController {

    
    @IBOutlet weak var actividad: UITextField!
    @IBOutlet weak var pickerOutlet: UIDatePicker!
    
    var dateRegist: daySelected!
    var dateCollectionR = [daySelected]()
    var strDate: String!
    var meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"]
    var month: String = ""
    var year: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickerAction(_ sender: UIDatePicker) {
        getDatePicker()
    }
    
    @IBAction func guardar(_ sender: UIButton) {
        
        getDatePicker()
        
        let registD = UserDefaults.standard
        
        guard strDate != nil else { return }
        
        dateRegist = daySelected(day: strDate, month: month, year: year, description: actividad.text!)
        
        if let listEvents = registD.value(forKey: "dateEvents") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<daySelected>.self, from: listEvents)
            
            dateCollectionR = temp!
        }
        
        dateCollectionR.append(dateRegist)
        
        registD.set(try? PropertyListEncoder().encode(dateCollectionR), forKey: "dateEvents")
        
        print("Ya se registró") //Agregar alerta
        
        print(dateCollectionR)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func getDatePicker() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Month"
        var m = dateFormatter.string(from: pickerOutlet.date)
        month = meses[Int(m)!-1]
        dateFormatter.dateFormat = "dd"
        strDate = dateFormatter.string(from: pickerOutlet.date)
        dateFormatter.dateFormat = "yyyy"
        year = dateFormatter.string(from: pickerOutlet.date)
    }
}
