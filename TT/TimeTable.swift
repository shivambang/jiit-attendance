//
//  TimeTable.swift
//  TT
//
//  Created by Shivam Bang on 24/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class TimeTable: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var data: [[CellData]] = [[], [], [], [], [], []]
    var day: Int = 0
    var mode: Int = 0
    let cellID = "cellID"
    var segments: UISegmentedControl!
    var tableView: UITableView!
    var del: Set<Int>!
    override func viewDidLoad(){
        super.viewDidLoad()
        navigationItem.title = "Time Table"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(TimeTable.edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TimeTable.add))
        self.view.backgroundColor = .white
        let toolbar = UINavigationBar(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 56))
        segments = UISegmentedControl(items: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"])
        segments.selectedSegmentIndex = 0
        segments.frame = CGRect(x: 16, y: 12, width: UIScreen.main.bounds.width - 32, height: 30)
        segments.addTarget(self, action: #selector(TimeTable.reload), for: .valueChanged)
        toolbar.addSubview(segments)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        //toolbar.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        //toolbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.view.addSubview(toolbar)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 120, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TimeTCell.self, forCellReuseIdentifier: cellID)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        //tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        self.view.addSubview(tableView)
        //view.addConstraintsWithFormat(format: "H:|[v0]|", views: toolbar)
        //view.addConstraintsWithFormat(format: "V:|[v0(40)]|", views: toolbar)
        
        NotificationCenter.default.addObserver(self, selector: #selector(TimeTable.refresh), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        if UserDefaults.standard.array(forKey: "TT") != nil{
            let arr = UserDefaults.standard.stringArray(forKey: "TT")
            var i = 0
            var cell = CellData()
            for x in arr!{
                switch i {
                case 0:
                    cell = CellData()
                    cell.type = x
                case 1:
                    cell.sub = Int(x)
                case 2:
                    cell.day = Int(x)
                case 3:
                    cell.time = x
                case 4:
                    cell.place = x
                    TimeTable.data[cell.day!].append(cell)
                default:
                    i = 0
                }
                i += 1
                i %= 5
            }
            sort()
        }
    }
    func add(sender: UIBarButtonItem){
        let vc = AddEntry()
        //vc.modalPresentationStyle = .popover
        //let pop: UIPopoverPresentationController = vc.popoverPresentationController!
        //pop.barButtonItem = sender
        //pop.delegate = vc.self
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    func edit(sender: UIBarButtonItem){
        mode = 1
        del = []
        tableView.allowsMultipleSelection = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(TimeTable.cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(TimeTable.editDone))
    }
    func editDone(sender: UIBarButtonItem){
        mode = 0
        for i in del.sorted(by: >){
            TimeTable.data[segments.selectedSegmentIndex].remove(at: i)
        }
        tableView.reloadData()
        tableView.allowsMultipleSelection = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(TimeTable.edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TimeTable.add))
        var arr: [String] = []
        for i in 0...5{
            for data in TimeTable.data[i]{
                arr.append(data.type!)
                arr.append(String(data.sub!))
                arr.append(String(data.day!))
                arr.append(data.time!)
                arr.append(data.place!)
            }
        }
        UserDefaults.standard.set(arr, forKey: "TT")
    }
    func cancel(sender: UIBarButtonItem){
        mode = 0
        tableView.allowsMultipleSelection = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(TimeTable.edit))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(TimeTable.add))
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TimeTable.data[day].count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TimeTCell
        cell.data = TimeTable.data[day][indexPath.item]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if mode == 1{
            del.insert(indexPath.item)
        }
        else{
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if mode == 1{
            del.remove(indexPath.item)
        }
    }
    func refresh(notification: NSNotification){
        sort()
        self.tableView.reloadData()
    }
    func reload(segment: UISegmentedControl){
        self.day = segment.selectedSegmentIndex
        self.tableView.reloadData()
    }
    func sort(){
        for i in 0...5{
            TimeTable.data[i].sort(by: {(cd1, cd2) -> Bool in
                let df = DateFormatter()
                var d1 = Date(), d2 = Date()
                df.setLocalizedDateFormatFromTemplate("h:mm a")
                d1 = df.date(from: cd1.time!)!
                d2 = df.date(from: cd2.time!)!
                return d1 < d2
            })
        }
    }
}
