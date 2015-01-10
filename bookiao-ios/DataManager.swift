//
//  DataManager.swift
//  bookiao-ios
//
//  Created by Xiomara on 12/29/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

typealias AnyArray = [AnyObject]

class DataManager {

    class var sharedManager: DataManager {
        struct Singleton {
            static let instance = DataManager()
        }
        return Singleton.instance
    }
    
    var date  = String()
    var token = String()
    var dateLabel = String()
    
    var Title  = "Bookealo"
    var phrase = "La cita comienza a las"
    var status = "No tienes citas para hoy. Crea una cita."
    
    var titles = AnyArray()
    var client = AnyArray()
    var services  = AnyArray()
    var employees = AnyArray()
    var employeeAppointments = AnyArray()
    var clientAppointments   = AnyArray()
    var clientAppointmentsPerDay   = AnyArray()
    var employeeAppointmentsPerDay = AnyArray()
    
    var userInfo = NSDictionary()
    
}
