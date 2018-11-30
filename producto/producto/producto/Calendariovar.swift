//
//  Calendariovar.swift
//  producto
//
//  Created by macbook on 21/11/18.
//  Copyright © 2018 potato. All rights reserved.
//

import Foundation
let date = Date()
let calendario = Calendar.current

let day = calendario.component(.day, from: date)
var weekday = calendario.component(.weekday, from: date) - 1
var month = calendario.component(.month, from: date) - 1
var year = calendario.component(.year, from: date)


