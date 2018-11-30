//
//  InicioViewController.swift
//  producto
//
//  Created by macbook on 11/26/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class InicioViewController: UIViewController {

    var listEvents = [daySelected]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "regist"{
            let ofManual = segue.destination as? RegistrarDatosViewController
            
            ofManual?.dateCollectionR = listEvents
        }
        if segue.identifier == "welcome"{
            let ofCalendar = segue.destination as? addManualViewController
            
            ofCalendar?.dateCollectionR = listEvents
        }
    }


}
