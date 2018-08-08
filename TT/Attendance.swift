//
//  Attendance.swift
//  TT
//
//  Created by Shivam Bang on 25/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSoup


class Attendance: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var cellID: String = "cellID"
    static var attendance: [CellData]!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Attendance"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.delaysContentTouches = false
        collectionView?.register(Cell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.refreshControl = UIRefreshControl()
        collectionView?.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControlEvents.valueChanged)
    }

    func refresh(sender: AnyObject){
        update(){ re in
            Attendance.attendance = re
            self.collectionView?.reloadData()
            self.collectionView?.refreshControl?.endRefreshing()
        }
    }

    func update(completion: @escaping([CellData]) -> Void) {
        Login().login(){ (cookie, re) in
            let urlstr: String = "https://webkiosk.jiit.ac.in/StudentFiles/Academic/StudentAttendanceList.jsp"
            let url: URL = URL(string: urlstr)!
            
            Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookie, for: url, mainDocumentURL: nil)
            Alamofire.request(urlstr).responseString
                {   (response) -> Void in
                    if let resposecode = response.response?.statusCode {
                        if resposecode != 200 {
                            // error
                        } else {
                            // view all cookies
                            var attd: [CellData] = []
                            do {
                                let doc: Document = try SwiftSoup.parse(response.result.value!)
                                let els: Elements = try (doc.body()?.getElementsByTag("table").get(2).getElementsByTag("tbody").get(0).children())!
                                for el: Element in els.array(){
                                    let subels: Elements = el.children()
                                    var name: String = try subels.get(1).text()
                                    name = name.substring(to: name.characters.index(of: "-")!)
                                    var dict: [String:String] = [:]
                                    dict["O"] = try subels.get(2).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                    dict["L"] = try subels.get(3).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                    dict["T"] = try subels.get(4).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                    dict["P"] = try subels.get(5).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                    var durl = ""
                                    if dict["O"] == ""{
                                        durl = try subels.get(5).getElementsByTag("a").attr("href").replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                    }
                                    else{
                                        durl = try subels.get(2).getElementsByTag("a").attr("href").replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                    }
                                    var data = CellData()
                                    data.subject = name
                                    data.attd = dict
                                    if durl == "" {
                                        data.detail = nil
                                    }
                                    else {
                                        durl = "https://webkiosk.jiit.ac.in/StudentFiles/Academic/\(durl)"
                                        Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookie, for: URL(string: durl)!, mainDocumentURL: nil)
                                        Alamofire.request(durl).responseString { (re) -> Void in
                                            if let resposecode = response.response?.statusCode {
                                                if resposecode != 200 {
                                                    // error
                                                    data.detail = nil
                                                } else {
                                                    // view all cookies
                                                    do {
                                                        var arr: [[String:String]] = []
                                                        let doc: Document = try SwiftSoup.parse(re.result.value!)
                                                        let els: Elements = try (doc.body()?.getElementsByTag("table").get(2).getElementsByTag("tbody").get(0).children())!
                                                        for el: Element in els.array(){
                                                            let subels: Elements = el.children()
                                                            var de: [String:String] = [:]
                                                            de["D"] = try subels.get(1).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                                            de["F"] = try subels.get(2).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                                            de["S"] = try subels.get(3).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                                            if subels.size() >= 6 {
                                                                de["T"] = try subels.get(5).text().replacingOccurrences(of: "&nbsp;", with: "").replacingOccurrences(of: "\u{00A0}", with: "")
                                                            }
                                                            else{
                                                                de["T"] = "Practical"
                                                            }
                                                            arr.append(de)
                                                        }
                                                        data.detail = arr
                                                    }
                                                    catch {
                                                        print("Error Details")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    attd.append(data)
                                }
                                completion(attd);
                            }
                            catch{
                                print("Error")
                            }
                        }
                    }
            }
            
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Attendance.attendance.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! Cell
        cell.backgroundColor = UIColor.white
        cell.data = Attendance.attendance[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 90.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0	
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Details.details = Attendance.attendance[indexPath.item].detail
        ViewController.attendanceBar.pushViewController(Details(), animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor(red: 224 / 255, green: 224 / 255, blue: 224 / 255, alpha: 1)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.white
    }
}
