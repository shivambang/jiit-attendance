//
//  Login.swift
//  TT
//
//  Created by Shivam Bang on 26/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import Alamofire
import SwiftSoup

class Login {
    func update(completion: @escaping ([HTTPCookie], String) -> Void) {
        var cookie: [HTTPCookie]!
        var cap: String!
        Alamofire.request("https://webkiosk.jiit.ac.in/", method: .get).responseString { (responseObject) -> Void in
            
            if let resposecode = responseObject.response?.statusCode {
                if resposecode != 200 {
                    // error
                } else {
                    // view all cookies
                    cookie = HTTPCookieStorage.shared.cookies(for: URL(string: "https://webkiosk.jiit.ac.in/")!)!
                    do {
                        let els: Elements = try SwiftSoup.parse(responseObject.result.value!).select("font")
                        for el: Element in els.array(){
                            if el.hasAttr("face")   {
                                let s: String = try el.attr("size")
                                let f: String = try el.attr("face")
                                if s == "5" && f.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "casteller"    {
                                    cap = try el.text().trimmingCharacters(in: .whitespacesAndNewlines)
                                }
                            }
                        }
                        
                    }
                    catch Exception.Error( _, let mssg){
                        print(mssg)
                    }
                    catch   {
                        print("Error")
                    }
                    completion(cookie, cap)
                }
            }
        }
    }
    
    func login(completion: @escaping ([HTTPCookie], String) -> Void)   {
        update() { (cookie, cap) in
            let params: Parameters = [
                "x":"null",
                "txtInst":"Institute",
                "InstCode":"JIIT",
                "UserType":"S",
                "MemberCode":"",
                "DATE1":"",
                "Password":"",
                "BTNSubmit":"Submit",
                "txtcap":cap
            ]
            let urlstr: String = "https://webkiosk.jiit.ac.in/CommonFiles/UserAction.jsp"
            let url: URL = URL(string: urlstr)!
            Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookie, for: url, mainDocumentURL: nil)
            Alamofire.request(urlstr, parameters: params).responseString
                {   (response) -> Void in
                    if let resposecode = response.response?.statusCode {
                        if resposecode != 200 {
                            // error
                        } else {
                            // view all cookies
                            completion(HTTPCookieStorage.shared.cookies(for: url)!, response.result.value!)
                        }
                    }
            }
        }
    }
}
