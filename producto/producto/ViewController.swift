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
    var isEventVC: Bool! = false
    var dateEventsVC = [daySelected]()
    var cellSelectedEvent: FechasCollectionViewCell!
    var colorEvent: UIColor! = UIColor(red: 100/250, green: 100/250, blue: 100/250, alpha: 0.3)
    
    let Meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre", "Diciembre"]
    let diasmes = ["Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Domingo"]
    var diasdelmes =  [31,28,31,30,31,30,31,31,30,31,30,31]
    var currentMes = String()
    
    var dayCounter = 0
    var numero = Int()
    var siguientenumero = Int()
    var anteriornumero = 0
    var direccion = 0
    var posicion = 0
    var yearbi = 2
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMes = Meses[month]
        labelmeses.text = "\(currentMes)\(year)"
        if weekday == 0{
            weekday = 7
        }
        GetStartDateDayPosition()
        
        let registDate = UserDefaults.standard
        
//        en caso de crasheo
//        registDate.removeObject(forKey: "dateEvents")
        if let listEvents = registDate.value(forKey: "dateEvents") as? Data{
            let temp = try? PropertyListDecoder().decode(Array<daySelected>.self, from: listEvents)
            
            dateEventsVC = temp!
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Tienes un evento"
        content.body = "Body"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        let request = UNNotificationRequest(identifier: "testIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
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
            //GetStartDateDayPosition()
           if yearbi > 0{
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
            anteriornumero = (7 - (diasdelmes[month]-posicion)%7)
            if anteriornumero == 7 {
                anteriornumero = 0
            }
            posicion = anteriornumero
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
        cell.fechalabel.textColor = UIColor.black
        cell.circulo.isHidden = true
        
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
            cell.fechalabel.text = "\(indexPath.row + 1 - anteriornumero)"
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
           // cell.backgroundColor = UIColor.yellow
            cell.circulo.isHidden = false
            cell.dibujacirculo()
        }
        
        //Revisa si hay un evento en la fecha
        if dateEventsVC.count != 0 {
            for i in 1...dateEventsVC.count {
                if cell.fechalabel.text! == dateEventsVC[i - 1].day {
                    if currentMes == dateEventsVC[i - 1].month {
                        cell.backgroundColor = colorEvent
                    }
                }
            }
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
        guard isEventVC == true else {
            cell.backgroundColor = UIColor.white
            
            return
        }
        cell.backgroundColor = colorEvent
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
