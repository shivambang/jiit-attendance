//
//  ViewController.swift
//  TT
//
//  Created by Shivam Bang on 24/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    static let attendanceBar = UINavigationController(rootViewController: Attendance(collectionViewLayout: UICollectionViewFlowLayout()))
    static let webBar = UINavigationController(rootViewController: Webkiosk())

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let tableBar = UINavigationController()
        Constants.subjects = defaults.stringArray(forKey: Constants.sub)
        Constants.attd = defaults.stringArray(forKey: "Attendance")
        //Constants.total = defaults.stringArray(forKey: "Total")
        tableBar.title = "Time Table"
        tableBar.viewControllers = [TimeTable()]
        ViewController.attendanceBar.pushViewController(Loader(), animated: true)
        ViewController.attendanceBar.title = "Attendance"
        let seatBar = UINavigationController(rootViewController: Seating())
        seatBar.title = "Seating Plan"
        ViewController.webBar.title = "Web View"
        let settingsBar = UINavigationController(rootViewController: Settings())
        settingsBar.title = "Settings"
        Attendance().update(){ re in
            Attendance.attendance = re
            ViewController.attendanceBar.popToRootViewController(animated: true)
            var subs: [String] = []
            var attd: [String] = []
            //var total: [Float] = []
            for data in re{
                subs.append(data.subject!)
                if data.attd?["O"] == ""{
                    attd.append((data.attd?["P"])!)
                }
                else{
                    attd.append((data.attd?["O"]!)!)
                }
            }
            defaults.set(subs, forKey: Constants.sub)
            defaults.set(attd, forKey: "Attendance")
            //defaults.set(total, forKey: "Total")
            Constants.subjects = subs
            Constants.attd = attd
            //Constants.total = total
        }
        tableBar.tabBarItem.image = #imageLiteral(resourceName: "report_card")
        ViewController.attendanceBar.tabBarItem.image = #imageLiteral(resourceName: "training")
        //seatBar.tabBarItem.image =
        ViewController.webBar.tabBarItem.image = #imageLiteral(resourceName: "laptop")
        settingsBar.tabBarItem.image = #imageLiteral(resourceName: "settings")
        viewControllers = [tableBar, ViewController.attendanceBar, ViewController.webBar]
    }
}
