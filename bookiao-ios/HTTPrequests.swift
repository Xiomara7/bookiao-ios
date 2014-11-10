//
//  HTTPrequests.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation

class HTTPrequests {
    
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    
    func registerRequest(email: NSString, name: NSString, phone: NSString, password: NSString, location: NSString, manager: NSString, business: NSString, bID: Int, usuario: NSString) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/register/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["email":email, "name":name, "phone_number": phone,"password":password] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)\n\n")
            println("Authenticating")
            self.authenticationRequest(email, name: name, phone: phone, password: password, location: location, manager: manager, business: business, bID: bID, usuario: usuario)
            var err: NSError?
            if !(data == nil) {
                println(error)
            }
            else {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                
                if((err) != nil) {
                    println(err!.localizedDescription)
                }
                else {
                    var success = json["response"] as? String
                    println("Succes: \(success)")
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
    
    func authenticationRequest(email: NSString, name: NSString, phone: NSString, password: NSString, location: NSString, manager: NSString, business: NSString, bID: Int, usuario: NSString) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/api-token-auth/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["email":email,"password":password] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)\n\n")
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            self.application.token = json["token"] as? String
            println("Succes")
            if usuario == "cliente" {
                println("is client")
                self.createClientRequest(email, name: name, phone: phone)
            }
            if usuario == "negocio" {
                println("is business")
                self.createBusinessRequest(email, name: name, phone: phone, manager: manager, location: location)
            }
            if usuario == "empleado" {
                println("is employee")
                self.createEmployeeRequest(email, name: name, phone: phone, business: bID)
            }
            var err: NSError?
            if !(data == nil) {
                println(error)
            }
            else {
                if((err) != nil) {
                    println(err!.localizedDescription)
                }
                else {
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
    
    func loginRequest(email: NSString, password: NSString, usuario: NSString) {
        var success = Bool()
        
        let login = LoginViewController(nibName: nil, bundle: nil)
        let views = ViewController(nibName: nil, bundle: nil)
        
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/api-token-auth/")
        var params  = ["email":email,"password":password] as Dictionary
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        var err: NSError?
        
        request.HTTPMethod = "POST"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            self.application.token = json["token"] as? String
            if(self.application.token == nil) {
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Error could not parse JSON: '\(jsonStr)'")
                login.emailtxtField.text  = ""
                login.passwdtxtField.text = ""
            
            }
            else {
                dispatch_sync(dispatch_get_main_queue(), {
//                    self.application.window.rootViewController = views
                    login.presentViewController(views, animated: true, completion: nil)
                })
                if usuario == "cliente" {
                    println("is client")
                    login.presentViewController(views, animated: true, completion: nil)
                }
                if usuario == "negocio" {
                    println("is business")
                    login.presentViewController(views, animated: true, completion: nil)
                }
                if usuario == "empleado" {
                    println("is employee")
                    login.presentViewController(views, animated: true, completion: nil)
                }
            }
        })
        task.resume()
    }
    
    func createClientRequest(email: NSString, name: NSString, phone: NSString) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/clients/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["email":email, "name":name, "phone_number":phone] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(self.application.token)", forHTTPHeaderField: "Authorization")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)\n\n")
            var err: NSError?
            if !(data == nil) {
                println(error)
            }
            else {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                
                if((err) != nil) {
                    println(err!.localizedDescription)
                }
                else {
                    var success = json["response"] as? String
                    println("Succes: \(success)")
                    println("Client created")
                    println(response)
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
    
    func createBusinessRequest(email: NSString, name: NSString, phone: NSString, manager: NSString, location: NSString) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/businesses/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["email":email, "name":name, "phone_number":phone, "manager_name": manager, "location":location] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(self.application.token)", forHTTPHeaderField: "Authorization")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)\n\n")
            
            var err: NSError?
            if !(data == nil) {
                println(error)
            }
            else {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                
                if((err) != nil) {
                    println(err!.localizedDescription)
                }
                else {
                    var success = json["response"] as? String
                    println("Succes: \(success)")
                    println("Business created")
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
    
    func createEmployeeRequest(email: NSString, name: NSString, phone: NSString, business: Int) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/employees/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["email":email, "name":name, "phone_number":phone, "business": business] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        request.addValue("JWT \(self.application.token)", forHTTPHeaderField: "Authorization")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)\n\n")
            
            var err: NSError?
            if !(data == nil) {
                println(error)
            }
            else {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                
                if((err) != nil) {
                    println(err!.localizedDescription)
                }
                else {
                    var success = json["response"] as? String
                    println("Succes: \(success)")
                    println("Employee created")
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
    
    func createAppointment(services: NSArray, employee: Int, client: Int, date: NSString, theTime: NSString){
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/appointments/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["day":date, "time": theTime, "services": services, "employee":employee, "client":client] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
        println("Token \(self.application.token)")
        request.addValue("JWT \(self.application.token)", forHTTPHeaderField: "Authorization")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)\n\n")
            
            var err: NSError?
            if !(data == nil) {
                println(error)
            }
            else {
                var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
                
                if((err) != nil) {
                    println(err!.localizedDescription)
                }
                else {
                    var success = json["response"] as? String
                    println("Succes: \(success)")
                    println("Employee created")
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
    
    func getBusinesses() {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/businesses/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newdata : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newdata["results"] as NSArray
            self.application.titles = jsonData as NSArray
            self.application.Bcount = newdata["count"] as Int
            println(jsonData)

            
        })
        task.resume()
    }
    
    func getClients() {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/clients/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.client = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Clients")
                dispatch_async(dispatch_get_main_queue(), {
                })
            }
        })
        task.resume()
    }
    
    func getAppointments() {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/appointments/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.appointments = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Appointments")
                dispatch_async(dispatch_get_main_queue(), {
                })
            }
        })
        task.resume()
    }
    
    func getEmployees() {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/employees/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.client = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Clients")
                dispatch_async(dispatch_get_main_queue(), {
                })
            }
        })
        task.resume()
    }
    
    func getServices() {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/services/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.client = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Clients")
                dispatch_async(dispatch_get_main_queue(), {
                })
            }
        })
        task.resume()
    }
}