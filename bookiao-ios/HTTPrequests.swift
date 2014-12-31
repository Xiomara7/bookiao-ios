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
    
    let baseURL: NSString = "https://bookiao-api.herokuapp.com"
    
    func initRequest(method: String!, url: NSURL!, params: NSDictionary?) -> NSMutableURLRequest {
        
        var request = NSMutableURLRequest(URL: url!)
        var err: NSError?
        
        if params != nil {
            request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params!, options: nil, error: &err)
        }
        request.HTTPMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if (DataManager.sharedManager.token as String! != nil) {
            request.addValue("JWT \(DataManager.sharedManager.token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
        
    }
    
    func registerRequest(email: NSString, name: NSString, phone: NSString, password: NSString, location: NSString, manager: NSString, business: NSString, bID: Int, usuario: NSString) {

        let url = NSURL(string: "\(baseURL)/register/")

        var params  = ["email":email, "name":name, "phone_number": phone,"password":password] as Dictionary
        var request = self.initRequest("POST", url: url, params: params)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
                if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
        
                    var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println("Body: \(strData)\n\n")
                    
                    self.authenticationRequest(email, name: name, phone: phone, password: password, location: location, manager: manager, business: business, bID: bID, usuario: usuario)

                    self.getUserInfo(email)
                }
            }
        })
        task.resume()
    }

    func authenticationRequest(email: NSString, name: NSString, phone: NSString, password: NSString, location: NSString, manager: NSString, business: NSString, bID: Int, usuario: NSString) {

        let url = NSURL(string: "\(baseURL)/api-token-auth/")

        var params  = ["email":email,"password":password] as Dictionary
        var request = self.initRequest("POST", url: url, params: params)
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
                if let httpResp = response as? NSHTTPURLResponse {
                    if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {

                        var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println("Body: \(strData)\n\n")
                        var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: nil) as NSDictionary
                        
                        DataManager.sharedManager.token = json["token"] as String!
                        
                        if usuario == "cliente" {
                            println("is client")
                            self.createClientRequest(email, name: name, phone: phone, completion: { (str, error) -> Void in
                                
                            })
                        }
                        if usuario == "negocio" {
                            println("is business")
                            self.createBusinessRequest(email, name: name, phone: phone, manager: manager, location: location, completion: { (str, error) -> Void in
                                return
                            })
                        }
                        if usuario == "empleado" {
                            println("is employee")
                            self.createEmployeeRequest(email, name: name, phone: phone, business: 1, completion: { (str, error) -> Void in
                                return
                            })
                        }
                    }
                }
        })
        task.resume()
    }

    func loginRequest(email: NSString, password: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        
        let url = NSURL(string: "\(baseURL)/api-token-auth/")
        
        var params  = ["email" : email,"password" : password] as Dictionary
        var request = self.initRequest("POST", url: url!, params: params)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println(response)
            if (response != nil) {
                let resp  = response as NSHTTPURLResponse!
                if (resp.statusCode == 200) {
                    var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:nil) as NSDictionary
                    if let block = completion {
                        println(json["token"] as String!)
                        let token = json["token"] as String!
                        block (str: token as String!, error: nil)
                    }
                }
                else {
                    if let block = completion {
                        block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))
                    }
                }
            }
            else {
                if let block = completion {
                    block (str: nil, error: nil)
                }
            }
        })
        task.resume()
    }

    
    func createClientRequest(email: NSString, name: NSString, phone: NSString, completion: ((str: String?, error:NSError?)-> Void)?)  {
        let url = NSURL(string: "\(baseURL)/clients/")
        var params = ["email":email, "name":name, "phone_number":phone] as Dictionary
        
        var request = self.initRequest("POST", url: url, params: params)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
                }}
            
            else {
                if let block = completion {
                    block (str: nil, error: NSError(domain: "Error", code: 0, userInfo: nil))
                }
            }
        })
        task.resume()
    }
    
    func createBusinessRequest(email: NSString, name: NSString, phone: NSString, manager: NSString, location: NSString, completion: ((str: String?, error:NSError?)-> Void)?) {
        let url = NSURL(string: "\(baseURL)/businesses/")

        var params  = ["email":email, "name":name, "phone_number":phone, "manager_name": manager, "location":location] as Dictionary
        var request = self.initRequest("POST", url: url, params: params)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
            }}
        })
        task.resume()
    }

    func createEmployeeRequest(email: NSString, name: NSString, phone: NSString, business: Int, completion: ((str: String?, error:NSError?)-> Void)?) {
        
        let url = NSURL(string: "\(baseURL)/employees/")
        
        var params  = ["email":email, "name":name, "phone_number":phone, "business": business] as Dictionary
        var request = self.initRequest("POST", url: url, params: params)
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
                }}
        })
        task.resume()
    }

    func editProfile(userType: NSString, id: Int, nombre: NSString, email: NSString, telefono: NSString, negocio: Int){
        
        let url = NSURL(string: "\(baseURL)/\(userType)/\(id)/")

        var params = ["email":email, "name":nombre, "phone_number": telefono, "business":negocio] as Dictionary
        var request = self.initRequest("PUT", url: url, params: params)
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:nil) as NSDictionary
                var success = json["response"] as? String!
                println("Succes: \(success)")
                self.getClients()
                self.getEmployees()
                self.getUserInfo(email)
            }}
        })
        task.resume()
    }

    func createAppointment(services: NSArray, employee: NSString, client: NSString, date: NSString, theTime: NSString){
        let url = NSURL(string: "\(baseURL)/appointments/")

        var params = ["day":date, "time": theTime, "services": services, "employee":employee, "client":client] as Dictionary
        var request = self.initRequest("POST", url: url, params: params)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)\n\n")
                }}
        })
        task.resume()
    }

    func getBusinesses() {
        let url = NSURL(string: "\(baseURL)/businesses/")

        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newdata : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary!
                
                let jsonData = newdata["results"] as NSArray
                
                DataManager.sharedManager.titles = jsonData as NSArray
            }}
        })
        task.resume()
    }

    func getClients() {
        let url = NSURL(string: "\(baseURL)/clients/")

        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {

                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let jsonData = newData["results"] as NSArray
                
                DataManager.sharedManager.client = jsonData as NSArray
            }}
        })
        task.resume()
    }

    func getEmployeeAppointments(id: Int) {
        let url = NSURL(string: "\(baseURL)/appointments/?employee=\(id)&ordering=time")

        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let jsonData = newData["results"] as NSArray
                
                DataManager.sharedManager.employeeAppointments = jsonData as NSArray
                println("Body: \(strData)\n\n")
                
                let login = LoginViewController(nibName: nil, bundle: nil)
                let views = ViewController(nibName: nil, bundle: nil)
                
                login.presentViewController(views, animated: true, completion: nil)
            }}
        })
        task.resume()
    }

    func getEmployeeAppointmentsPerDay(id: Int, date: NSString) {
        let url = NSURL(string: "\(baseURL)/appointments/?day=\(date)&employee=\(id)&ordering=time")
        
        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
            
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let jsonData = newData["results"] as NSArray
                
                DataManager.sharedManager.employeeAppointmentsPerDay = jsonData as NSArray
                println("Body: \(strData)\n\n")

                let login = LoginViewController(nibName: nil, bundle: nil)
                let views = ViewController(nibName: nil, bundle: nil)
                login.presentViewController(views, animated: true, completion: nil)
            }}
        })
        task.resume()
    }

    func getClientAppointmentsPerDay(id: Int, date: NSString) {
        let url = NSURL(string: "\(baseURL)/appointments/?day=\(date)&client=\(id)&ordering=time")
        
        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
            
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let jsonData = newData["results"] as NSArray
                DataManager.sharedManager.clientAppointmentsPerDay = jsonData as NSArray
                
                println("Body: \(strData)\n\n")
                
                let login = LoginViewController(nibName: nil, bundle: nil)
                let views = ViewController(nibName: nil, bundle: nil)
                login.presentViewController(views, animated: true, completion: nil)
            }}
        })
        task.resume()
    }

    func getClientAppointments(id: Int) {
        let url = NSURL(string: "\(baseURL)/appointments/?client=\(id)&ordering=time")
        
        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()
    
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {

                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                let jsonData = newData["results"] as NSArray
                
                DataManager.sharedManager.clientAppointments = jsonData as NSArray
                
                println("Body: \(strData)\n\n")
                println("got Appointments")
            
                let login = LoginViewController(nibName: nil, bundle: nil)
                let views = ViewController(nibName: nil, bundle: nil)
                login.presentViewController(views, animated: true, completion: nil)
            }}
        })
        task.resume()
    }

    func getEmployees() {
        let url = NSURL(string: "\(baseURL)/employees/")
        
        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                DataManager.sharedManager.employees = newData["results"] as NSArray
                
            }}
        })
        task.resume()
    }

    func getServices() {
        let url = NSURL(string: "\(baseURL)/services/")
        
        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {

                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary

                DataManager.sharedManager.services = newData["results"] as NSArray
            }}
        })
        task.resume()
    }

    func getUserInfo(email: NSString) {
        let url = NSURL(string: "\(baseURL)/user-type/?email=\(email)")
        
        var request = self.initRequest("GET", url: url, params: nil)
        var session = NSURLSession.sharedSession()

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if let httpResp = response as? NSHTTPURLResponse {
            if (httpResp.statusCode >= 200 && httpResp.statusCode < 300) {
                
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary!
                
                DataManager.sharedManager.userInfo = newData as NSDictionary!
                let id = DataManager.sharedManager.userInfo["id"] as Int!
                let ut = DataManager.sharedManager.userInfo["userType"] as String!
                if ut == "client" {
                    self.getClientAppointments(id)
                    self.getClientAppointmentsPerDay(id, date: DataManager.sharedManager.date)
                }
                if ut == "employee" {
                    self.getEmployeeAppointments(id)
                    self.getEmployeeAppointmentsPerDay(id, date: DataManager.sharedManager.date)
                    }
            }}
        })
        task.resume()
    }

    func subscription(email: NSString) {
        
        let url = NSURL(string: "\(baseURL)/betaemails/")
        
        var params  = ["email": email] as Dictionary
        var request = self.initRequest("POST", url: url!, params: params)
        var session = NSURLSession.sharedSession()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
        })
        task.resume()
    }
}