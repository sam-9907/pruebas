//
//  ActivitiesViewController.swift
//  producto
//
//  Created by macbook on 11/28/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var dateCollectionR = [daySelected]()
    
    
    @IBOutlet weak var activitiesTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let registD = UserDefaults.standard
        
        if let listEvents = registD.value(forKey: "dateEvents") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<daySelected>.self, from: listEvents)
            
            dateCollectionR = temp!
        }
        
        registD.set(try? PropertyListEncoder().encode(dateCollectionR), forKey: "dateEvents")
        
        print(dateCollectionR)
        return dateCollectionR.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = activitiesTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ActivitiesTableViewCell
        
        //cell?.actividad.text = userLoginList[indexPath.row].username
        
        cell?.actividad.text = dateCollectionR[indexPath.row].description
        cell?.mes.text = dateCollectionR[indexPath.row].month
        cell?.día.text = dateCollectionR[indexPath.row].day
        
        return cell!
    }
    
    
}
