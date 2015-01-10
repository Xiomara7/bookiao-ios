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
    var alertm = "Verifica tus credenciales y tu conección al internet!"
    
    var paragraph = "Hasta este momento nuestro app tiene solo un negocio beta. Si deseas ser parte del grupo de negocios beta, por favor déjanos tu correo electrónico utilizando los campos de abajo. \r \r Atentamente H3 at Bookiao."
    
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
