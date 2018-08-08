//
//  Details.swift
//  TT
//
//  Created by Shivam Bang on 27/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

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


class Details: UITableViewController {
    
    var cellID: String = "cellID"
    static var details: [[String:String]]?
    var ptdetails: [[String:String]] = []
    var ldetails: [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.backgroundColor = UIColor.white
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = UITableViewAutomaticDimension
        tableView?.register(TableCell.self, forCellReuseIdentifier: cellID)
        if Details.details != nil && Details.details!.count != 0{
        for d in Details.details!{
            if d["T"] == "Lecture"{
                ldetails.append(d)
            }
            else{
                ptdetails.append(d)
            }
        }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        if Details.details == nil || Details.details!.count == 0 {
            return 0
        }
        else if Details.details![0]["T"] == "Practical"  {
            return 1
        }
        else{
            return 2
        }
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var str: String!
        if Details.details == nil || Details.details!.count == 0 {
            str = ""
        }
        else if Details.details![0]["T"] == "Practical"  {
            str = "Practical"
        }
        else{
            if section == 0{
                str = "Tutorial"
            }
            else {
                str = "Lecture"
            }
        }
        return str
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Details.details == nil || Details.details!.count == 0 {
            return 0
        }
        else{
            if section == 0{
                return ptdetails.count
            }
            else {
                return ldetails.count
            }
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableCell
        cell.backgroundColor = UIColor.white
        if Details.details == nil || Details.details!.count == 0{
            cell.data = Details.details?[indexPath.item]
        }
        else{
            cell.data = indexPath.section == 0 ? ptdetails[indexPath.item] : ldetails[indexPath.item]
        }
        return cell
    }

}
