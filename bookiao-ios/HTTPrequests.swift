//
//  HTTPrequests.swift
//  bookiao-ios
//
//  Created by Xiomara on 11/5/14.
//  Copyright (c) 2014 UPRRP. All rights reserved.
//

import Foundation
import Alamofire
class HTTPrequests {
    
    let application = UIApplication.sharedApplication().delegate as AppDelegate
    func registerRequest(email: NSString, name: NSString, phone: NSString, password: NSString, location: NSString, manager: NSString, business: NSString, bID: Int, usuario: NSString) {
        self.getUserInfo(email)
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
        let views = ViewController(nibName: nil, bundle: nil)
        let login = LoginViewController(nibName: nil, bundle: nil)
        
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
            println("Response: \(data)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as NSDictionary
            self.application.token = json["token"] as String!
            if(self.application.token == nil) {
//                let alert = UIAlertView(title: "INVALID LOGIN", message: "try again!", delegate: login, cancelButtonTitle: "OK")
//                alert.show()
                let jsonStr = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("INVALID LOGIN")
            }
            else {
                dispatch_sync(dispatch_get_main_queue(), {
                    self.getUserInfo(email)
                })
            }
        })
        task.resume()
    }
    
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            println("OK")
            let login = LoginViewController(nibName: nil, bundle: nil)
            self.application.window.rootViewController = login
            
        }
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
    
    func editProfile(userType: NSString, id: Int, nombre: NSString, email: NSString, telefono: NSString, negocio: Int){
        let url = NSURL(string: "https://http://bookiao-api.herokuapp.com/\(userType)/\(id)/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "PUT"
        request.addValue("JWT \(self.application.token)", forHTTPHeaderField: "Authorization")
        var params = ["email":email, "name":nombre, "phone_number": telefono, "business":negocio] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
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
                    println("User Info Updated")
                    dispatch_async(dispatch_get_main_queue(), {
                        self.getClients()
                        self.getEmployees()
                        self.getUserInfo(email)
                    })
                }
            }
        })
        task.resume()
    }
    
    func createAppointment(services: NSArray, employee: NSString, client: NSString, date: NSString, theTime: NSString){
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
            if (response == nil) {
                println(error)
            }
            else {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newdata : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary!
                let jsonData = newdata["results"] as NSArray
                self.application.titles = jsonData as NSArray
            println(jsonData)
            }
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
            if (response == nil) {
                println(error)
            }
            else {
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let jsonData = newData["results"] as NSArray
                self.application.client = jsonData as NSArray
                println("Body: \(strData)\n\n")
                println("got Clients")
                dispatch_async(dispatch_get_main_queue(), {
                })
            }
        })
        task.resume()
    }
    
    func getEmployeeAppointments(id: Int) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/appointments/?employee=\(id)&ordering=time")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.employeeAppointments = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Appointments")
                dispatch_async(dispatch_get_main_queue(), {
                    let login = LoginViewController(nibName: nil, bundle: nil)
                    let views = ViewController(nibName: nil, bundle: nil)
                    login.presentViewController(views, animated: true, completion: nil)
                })
            }
        })
        task.resume()
    }
    
    func getEmployeeAppointmentsPerDay(id: Int, date: NSString) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/appointments/?day=\(date)&employee=\(id)&ordering=time")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.employeeAppointmentsPerDay = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Appointments")
                dispatch_async(dispatch_get_main_queue(), {
                    let login = LoginViewController(nibName: nil, bundle: nil)
                    let views = ViewController(nibName: nil, bundle: nil)
                    login.presentViewController(views, animated: true, completion: nil)
                })
            }
        })
        task.resume()
    }
    
    func getClientAppointmentsPerDay(id: Int, date: NSString) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/appointments/?day=\(date)&client=\(id)&ordering=time")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.clientAppointmentsPerDay = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Appointments")
                dispatch_async(dispatch_get_main_queue(), {
                    let login = LoginViewController(nibName: nil, bundle: nil)
                    let views = ViewController(nibName: nil, bundle: nil)
                    login.presentViewController(views, animated: true, completion: nil)
                })
            }
        })
        task.resume()
    }
    
    func getClientAppointments(id: Int) {
        let url = NSURL(string: "https://bookiao-api.herokuapp.com/appointments/?client=\(id)&ordering=time")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
            let jsonData = newData["results"] as NSArray
            self.application.clientAppointments = jsonData as NSArray
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (data == nil) {
                println(error)
            }
            else {
                println("got Appointments")
                dispatch_async(dispatch_get_main_queue(), {
                    let login = LoginViewController(nibName: nil, bundle: nil)
                    let views = ViewController(nibName: nil, bundle: nil)
                    login.presentViewController(views, animated: true, completion: nil)
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
            if response == nil {
                println(error)
            }
            else {
                println("got Employees")
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                let jsonData = newData["results"] as NSArray
                self.application.employees = jsonData as NSArray
                println("Body: \(strData)\n\n")
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
            if (response == nil) {
                println(error)
            }
            else {
                println("got Services")
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
                var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary!
                let jsonData = newData["results"] as NSArray
                self.application.services = jsonData as NSArray
                println("Body: \(strData)\n\n")
            }
        })
        task.resume()
    }
    
    func getUserInfo(email: NSString) {
        let login = LoginViewController(nibName: nil, bundle: nil)
        let views = ViewController(nibName: nil, bundle: nil)
        let url = NSURL(string: "http://bookiao-api.herokuapp.com/user-type/?email=\(email)")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        var err: NSError?
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)!
            var newData : NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary!
            let jsonData = newData as NSDictionary
            self.application.userInfo = jsonData as NSDictionary
            println(jsonData)
            println("Body: \(strData)\n\n")
            var err: NSError?
            if (self.application.userInfo["userType"] as String == "none") {
                let alert = UIAlertView(title: "INVALID LOGIN", message: "try again!", delegate: login, cancelButtonTitle: "OK")
                alert.show()
            }
            else {
                println("got UserInfo")
                dispatch_async(dispatch_get_main_queue(), {
                    self.application.window.rootViewController = views
                    if self.application.userInfo["userType"] as String! == "client" {
                        self.getClientAppointments(self.application.userInfo["id"] as Int)
                        self.getClientAppointmentsPerDay(self.application.userInfo["id"] as Int, date: self.application.date)
                    }
                    if self.application.userInfo["userType"] as String! == "employee" {
                        self.getEmployeeAppointments(self.application.userInfo["id"] as Int)
                        self.getEmployeeAppointmentsPerDay(self.application.userInfo["id"] as Int, date: self.application.date)
                    }
                })
            }
        })
        task.resume()
    }
    
    func subscription(email: NSString) {
        let url = NSURL(string: "http://bookiao-api.herokuapp.com/betaemails/")
        var request = NSMutableURLRequest(URL: url!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        var params = ["email": email] as Dictionary
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Application/json", forHTTPHeaderField: "Accept")
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
                    println("Subscription created")
                    dispatch_async(dispatch_get_main_queue(), {
                    })
                }
            }
        })
        task.resume()
    }
}