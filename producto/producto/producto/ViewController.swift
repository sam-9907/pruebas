//
//  ViewController.swift
//  producto
//
//  Created by macbook on 21/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    @IBOutlet weak var Calendario: UICollectionView!
    @IBOutlet weak var labelmeses: UILabel!
    
    var dayS: String!
    var monthS: String!
    
    let Meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre", "Diciembre"]
    let diasmes = ["Lunes","Martes","Miercoles","Jueves","Viernes"]
    var diasdelmes =  [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMes = String()
    var yearbi = 2
    
    var dayCounter = 0
    var numero = Int()
    var siguientenumero = Int()
    var anteriornumero = 0
    var direccion = 0
    var posicion = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = "Tienes un evento"
        content.body = "Body"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    
    currentMes = Meses[month]
    labelmeses.text = "\(currentMes)\(year)"
        if weekday == 0{
            weekday = 7
        }
     GetStartDateDayPosition()
    }

   

    @IBAction func siguiente(_ sender: Any) {
        switch currentMes {
        case "Diciembre":
            month = 0
            year += 1
            direccion = 1
            if yearbi < 5{
                yearbi += 1
            }
            if yearbi == 4{
                diasdelmes[1] = 29
            }
            if yearbi == 5{
                yearbi = 1
              diasdelmes[1] = 28
            }
            GetStartDateDayPosition()
            currentMes = Meses[month]
            labelmeses.text = "\(currentMes)\(year)"
            Calendario.reloadData()
        default:
            
            direccion = 1
            GetStartDateDayPosition()
            month += 1
            currentMes = Meses[month]
            labelmeses.text = "\(currentMes)\(year)"
            Calendario.reloadData()
        }
    }
  
    @IBAction func atras(_ sender: Any) {
        switch currentMes {
        case "Enero":
            month = 11
            year -= 1
            direccion = -1
            if yearbi < 0{
                yearbi -= 1
            }
            if yearbi == 0{
                diasdelmes[1] = 29
                yearbi = 4
            }else{
                diasdelmes[1] = 28
            }
            GetStartDateDayPosition()
            currentMes = Meses[month]
            labelmeses.text = "\(currentMes)\(year)"
            Calendario.reloadData()
        default:
            month -= 1
            direccion = -1
            GetStartDateDayPosition()
            currentMes = Meses[month]
            labelmeses.text = "\(currentMes)\(year)"
            Calendario.reloadData()
        }
    }
    
    func GetStartDateDayPosition(){
        switch direccion {
        case 0:
           numero = weekday
            dayCounter = day
            while dayCounter > 0{
                numero = numero - 1
                dayCounter = dayCounter - 1
                if numero == 0{
                    numero = 7
                }}
           
                if numero == 7{
                    numero = 0
                }
                
        
            
            posicion = numero
        case 1...:
            siguientenumero = (posicion + diasdelmes[month])%7
            posicion = siguientenumero
        
        case -1:
            anteriornumero = (7-(diasdelmes[month]-posicion)%7)
            if anteriornumero == 7 {
                anteriornumero = 0
            }
        default:
            fatalError()
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return diasdelmes[month]
        switch direccion {
        case 0:
            return diasdelmes[month] + numero
        case 1...:
            return diasdelmes[month] + siguientenumero
        case -1:
            return diasdelmes[month]  + anteriornumero
        default:
            fatalError()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Calendario", for: indexPath)as! FechasCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.fechalabel.textColor = UIColor.red
        //cell.fechalabel.text = "\(indexPath.row + 1)"
        if cell.isHidden{
            cell.isHidden = false 
        }
        switch direccion {
        case 0:
            cell.fechalabel.text = "\(indexPath.row + 1 - numero)"
        case 1:
            cell.fechalabel.text = "\(indexPath.row + 1 - siguientenumero)"
        case -1:
             cell.fechalabel.text = "\(indexPath.row + 1 - siguientenumero)"
        default:
            fatalError()
        }
    
        
    if Int(cell.fechalabel.text!)! < 1{
    cell.isHidden = true
    }
        switch indexPath.row {
        case 5,6,12,13,19,20,26,27,33,34:
            if Int(cell.fechalabel.text!)! > 0{
                cell.fechalabel.textColor = UIColor.lightGray
            }
        default:
            break
        }
        if currentMes == Meses[calendario.component(.month, from: date) - 1] && year == calendario.component(.year, from: date) && indexPath.row + 1 == day{
         cell.backgroundColor = UIColor.yellow
        }
        
      return cell
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = (collectionView.cellForItem(at: indexPath)! as? FechasCollectionViewCell)!
        
        cell.backgroundColor = UIColor.init(red: 2/250, green: 2/250, blue: 200/250, alpha: 0.3)
        
        guard cell.fechalabel.text != nil else { return }
            
        print(cell.fechalabel.text!)
        print(labelmeses.text!)
        dayS = cell.fechalabel.text as! String
        monthS = labelmeses.text as! String
        
        self.performSegue(withIdentifier: "toRegistrarDatos", sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = (collectionView.cellForItem(at: indexPath)! as? FechasCollectionViewCell)!
        cell.backgroundColor = UIColor.white
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRegistrarDatos"{

            let indexPath = Calendario.indexPathsForSelectedItems

            let destino = segue.destination as? RegistrarDatosViewController
            
            destino?.dia = dayS
            destino?.mes = monthS
        }
    }
}





