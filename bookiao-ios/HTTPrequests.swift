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
}