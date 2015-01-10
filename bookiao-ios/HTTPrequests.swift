//
//  HTTPrequests.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HTTPrequests {
    
    class var sharedManager: HTTPrequests {
        struct Singleton {
            static let instance = HTTPrequests()
        }
        return Singleton.instance
    }
    
    let baseURL: NSString = "https://bookiao-api-staging.herokuapp.com"
    
    func initRequest(method: String!, url: NSURL!, params: NSDictionary?) -> NSMutableURLRequest {
        
        println(method)
        
        var request = NSMutableURLRequest(URL: url!)
        var err: NSError?
    
        request.HTTPMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        if params != nil {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params!, options: nil, error: &err)
        }
        if (DataManager.sharedManager.token as String! != nil) {
            request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
        
    }
    
    func isRequestValid(response: NSURLResponse?) -> Bool {
        if response != nil {
            let resp = response as NSHTTPURLResponse!
            if (resp.statusCode >= 200
            &&  resp.statusCode < 300) {return true}
        }
        return false
    }
    
    func registerRequest(email: NSString, name: NSString, phone: NSString, passwd: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        var params  = ["email":email, "name":name, "phone_number": phone,"password":passwd] as Dictionary

        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/register/")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                if let block = completion {block (str: "ok", error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func authRequest(email: NSString, passwd: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        var params  = ["email":email,"password":passwd] as Dictionary

        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/api-token-auth/")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: nil) as NSDictionary
                DataManager.sharedManager.token = json["token"] as String!
                dispatch_async(dispatch_get_main_queue(), {
                    if self.isRequestValid(response) {
                        if let block = completion {block (str: "ok", error: nil)}
                        else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
                    }
                    else {if let block = completion {block (str: nil, error: nil)}}
                })
            }

        })
        task.resume()
    }

    func loginRequest(email: NSString, password: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        var params  = ["email" : email,"password" : password] as Dictionary
        var request = self.initRequest("POST", url: NSURL(string: "\(baseURL)/api-token-auth/")!, params: params)
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:nil) as NSDictionary
                if let block = completion {block (str: json["token"] as String!, error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func clientsReq(email: NSString, name: NSString, phone: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        var params  = ["email":email, "name":name, "phone_number":phone] as Dictionary

        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/clients/")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        
        println("token : \(DataManager.sharedManager.token)")
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Client response: \(response)")
            if self.isRequestValid(response) {
                if let block = completion {block (str: "ok", error: nil)}
            } else {if let block = completion {block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
        })
        task.resume()
    }
    
    func createBusinessRequest(email: NSString, name: NSString, phone: NSString, man: NSString, loc: NSString, completion: ((str: String?, error:NSError?)-> Void)?) {
        var params  = ["email":email, "name":name, "phone_number":phone, "manager_name": man, "location":loc] as Dictionary
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/businesses/")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println(response)
            if self.isRequestValid(response) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
            }
        })
        task.resume()
    }

    func employeeReq(email: NSString, name: NSString, phone: NSString, business: Int, completion: ((str: String?, error:NSError?)-> Void)?) {
        var params  = ["email":email, "name":name, "phone_number":phone, "business": business] as Dictionary
        
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/employees/")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
            }
        })
        task.resume()
    }

    func editProfile(userType: NSString, id: Int, nombre: NSString, email: NSString, telefono: NSString, negocio: Int){
        var params = ["email":email, "name":nombre, "phone_number": telefono, "business":negocio] as Dictionary
        
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/\(userType)/\(id)/")!)
        request.HTTPMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:nil) as NSDictionary
                var success = json["response"] as? String!
                println("Succes: \(success)")
                self.getClients()
                self.getEmployees()
                self.getUserInfo(email, completion: { (str, error) -> Void in
                    println("HELO")
                })
            }
        })
        task.resume()
    }

    func createAppointment(services: NSArray, employee: NSString, client: NSString, date: NSString, theTime: NSString){
        var params = ["day":date, "time": theTime, "services": services, "employee":employee, "client":client] as Dictionary
        
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/appointments/")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
            }
        })
        task.resume()
    }

    func getBusinesses() {

        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/businesses/")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println(response)
            if self.isRequestValid(response) {
                var newdata : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary!
                DataManager.sharedManager.titles = newdata["results"] as NSArray!
                println(DataManager.sharedManager.titles)
            }
        })
        task.resume()
    }

    func getClients() {
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/clients/")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println(response)
            if self.isRequestValid(response) {
                var newdata : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary!
                DataManager.sharedManager.client = newdata["results"] as NSArray!
                println(DataManager.sharedManager.client)
            }
        })
    }

    func getEmployeeAppointments(id: Int, completion: ((str: String?, error:NSError?)-> Void)?) {
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/appointments/?employee=\(id)&ordering=time")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
                DataManager.sharedManager.employeeAppointments = newData["results"] as NSArray
                if let block = completion {block (str: "ok" as String!, error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func getEmployeeAppointmentsPerDay(id: Int, date: NSString, completion: ((str: String?, error:NSError?)-> Void)?) {
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/appointments/?day=\(date)&employee=\(id)&ordering=time")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                DataManager.sharedManager.employeeAppointmentsPerDay = newData["results"] as NSArray
                if let block = completion {block (str: "ok" as String!, error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func getClientAppointmentsPerDay(id: Int, date: NSString, completion: ((str: String?, error:NSError?)-> Void)?) {
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/appointments/?day=\(date)&client=\(id)&ordering=time")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
                DataManager.sharedManager.clientAppointmentsPerDay = newData["results"] as NSArray
                if let block = completion {block (str: "ok" as String!, error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func getClientAppointments(id: Int, completion: ((str: String?, error:NSError?)-> Void)?) {
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/appointments/?client=\(id)&ordering=time")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
                DataManager.sharedManager.clientAppointments = newData["results"] as NSArray
                if let block = completion {block (str: "ok" as String!, error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func getEmployees() {

        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/employees/")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
                DataManager.sharedManager.employees = newData["results"] as NSArray!
                println(DataManager.sharedManager.employees)
            }
        })
        task.resume()
    }

    func getServices() {
        
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/services/")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary
                DataManager.sharedManager.services = newData["results"] as NSArray!
                println(DataManager.sharedManager.services)
            }
        })
        task.resume()
    }

    func getUserInfo(email: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/user-type/?email=\(email)")!)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                println("UserInfo Resp: \(response)")
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as NSDictionary!
                DataManager.sharedManager.userInfo = newData as NSDictionary!
                println("Userinfo: \(DataManager.sharedManager.userInfo)")
                let id = DataManager.sharedManager.userInfo["id"] as Int!
                let ut = DataManager.sharedManager.userInfo["userType"] as String!
                if ut == "client" {
                    self.getClientAppointments(id, completion: { (str, error) -> Void in
                    })
                    self.getClientAppointmentsPerDay(id, date: DataManager.sharedManager.date, completion: { (str, error) -> Void in
                    })
                }
                if ut == "employee" {
                    self.getEmployeeAppointments(id, completion: { (str, error) -> Void in
                    })
                    self.getEmployeeAppointmentsPerDay(id, date: DataManager.sharedManager.date, completion: { (str, error) -> Void in
                    })
                }
                if let block = completion {block (str: "ok" as String!, error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }

    func subscription(email: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        var params  = ["email": email] as Dictionary

        var request = NSMutableURLRequest(URL: NSURL(string: "\(baseURL)/betaemails")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: nil)

        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if self.isRequestValid(response) {
                println(response)
                if let block = completion {block (str: "ok", error: nil)}
                else {if let block = completion { block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))}}
            }
            else {if let block = completion {block (str: nil, error: nil)}}
        })
        task.resume()
    }
}