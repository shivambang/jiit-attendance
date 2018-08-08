//
//  AddEntry.swift
//  TT
//
//  Created by Shivam Bang on 29/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class AddEntry: UITableViewController, UIPopoverPresentationControllerDelegate{
    
    var cellID = "cellID"
    var hidden = [Bool](repeating: true, count: 4)
    var typePick, dayPick, subPick, timePick: Picker!
    var pick: [Picker] = []
    let dayPicker = UIPickerView(), typePicker = UIPickerView(), subPicker = UIPickerView()
    let timePicker = UIDatePicker()
    let place = TextCell()
    let date = DateFormatter()
    var arr: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96 , alpha: 1)
        navigationItem.title = "Add"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(AddEntry.cancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AddEntry.done))
        typePick = Picker(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        dayPick = Picker(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        subPick = Picker(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        timePick = Picker(style: UITableViewCellStyle.value1, reuseIdentifier: cellID)
        pick = [typePick, dayPick, subPick]
        typePick.data = Constants.types
        dayPick.data = Constants.days
        subPick.data = Constants.subjects!
        pinit(pick: typePick, picker: typePicker)
        pinit(pick: subPick, picker: subPicker)
        pinit(pick: dayPick, picker: dayPicker)
        date.setLocalizedDateFormatFromTemplate("h:mm a")
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(change), for: .valueChanged)
        timePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 144)
        hide()
        if UserDefaults.standard.stringArray(forKey: "TT") != nil{
            arr = UserDefaults.standard.stringArray(forKey: "TT")!
        }
    }
    func pinit(pick: Picker, picker: UIPickerView){
        picker.dataSource = pick
        picker.delegate = pick
        picker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 144)
    }
    func hide(){
        typePicker.isHidden = hidden[0]
        subPicker.isHidden = hidden[1]
        dayPicker.isHidden = hidden[2]
        timePicker.isHidden = hidden[3]
        place.textView.resignFirstResponder()
    }
    func hideandseek(index: Int){
        for i in 0..<4 {
            if i != index{
                hidden[i] = true
            }
        }
    }
    func change(){
        timePick.detailTextLabel?.text = "\(date.string(from: timePicker.date))"
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .fullScreen
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10))
        hv.backgroundColor = UIColor.clear
        return hv
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10))
        hv.backgroundColor = UIColor.clear
        return hv
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return " "
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 4
        }
        else{
            return 5
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row % 2 != 0{
            return hidden[indexPath.section*2 + indexPath.row / 2] ? 0.0 : 144.0
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0{
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID) ?? UITableViewCell(style: .value1, reuseIdentifier: cellID)
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 0:
                    cell = typePick
                    cell.textLabel?.text = "Type"
                    cell.detailTextLabel?.text = typePick.data[0]
                case 2:
                    cell = subPick
                    cell.textLabel?.text = "Subject"
                    cell.detailTextLabel?.text = subPick.data[0]
                default:
                    print("")
                }
            case 1:
                switch indexPath.row {
                case 0:
                    cell = dayPick
                    cell.textLabel?.text = "Day"
                    cell.detailTextLabel?.text = dayPick.data[0]
                case 2:
                    cell = timePick
                    cell.textLabel?.text = "Time"
                    cell.detailTextLabel?.text = "\(date.string(from: timePicker.date))"
                case 4:
                    place.configure(label: "Place", placeholder:"Enter Place Here")
                    cell = place
                default:
                    print("")
                }
            default:
                print("")
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID) ?? UITableViewCell(style: .default, reuseIdentifier: cellID)
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 1:
                    cell.addSubview(typePicker)
                case 3:
                    cell.addSubview(subPicker)
                default:
                    print("")
                }
            case 1:
                switch indexPath.row {
                case 1:
                   cell.addSubview(dayPicker)
                case 3:
                    cell.addSubview(timePicker)
                default:
                    print("")
                }
            default:
                print("")
            }
            return cell
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 4, section: 1){
            self.place.textView.becomeFirstResponder()
            self.place.textView.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        else if indexPath.row % 2 == 0{
            hideandseek(index: indexPath.section*2 + indexPath.row / 2)
            hide()
            gray()
            hidden[indexPath.section*2 + indexPath.row / 2] = !hidden[indexPath.section*2 + indexPath.row / 2]
            if hidden[indexPath.section*2 + indexPath.row / 2]{
                hide()
            }
            else{
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
                //tableView.reloadRows(at: [indexPath], with: .none)
            }
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                self.tableView.beginUpdates()
                self.tableView.deselectRow(at: indexPath, animated: true)
                self.tableView.endUpdates()
            }, completion: { (Bool) -> Void in
                self.hide()
            } )
        }
    }
    func gray(){
        
        tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.detailTextLabel?.textColor = UIColor.gray
        tableView.cellForRow(at: IndexPath(row: 2, section: 0))?.detailTextLabel?.textColor = UIColor.gray
        tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.detailTextLabel?.textColor = UIColor.gray
        tableView.cellForRow(at: IndexPath(row: 2, section: 1))?.detailTextLabel?.textColor = UIColor.gray
        place.textView.textColor = UIColor.gray
    }
    func cancel(){
        self.place.textView.resignFirstResponder()
        self.dismiss(animated: true, completion: nil)
    }
    func done(){
        self.place.textView.resignFirstResponder()
        let data: CellData = CellData()
        data.day = dayPicker.selectedRow(inComponent: 0)
        data.sub = subPicker.selectedRow(inComponent: 0)
        data.type = typePick.detailTextLabel?.text
        data.time = timePick.detailTextLabel?.text
        data.place = place.textView.text
        TimeTable.data[data.day!].append(data)
        arr.append(data.type!)
        arr.append(String(data.sub!))
        arr.append(String(data.day!))
        arr.append(data.time!)
        arr.append(data.place!)
        UserDefaults.standard.set(arr, forKey: "TT")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
}
