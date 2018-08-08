//
//  TextCell.swift
//  TT
//
//  Created by Shivam Bang on 02/08/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell, UITextFieldDelegate{
    
    let label = UILabel()
    let textView = UITextField()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(label: String, placeholder: String){
        self.label.text = label
        self.textView.placeholder = placeholder
    }
    func setupViews(){
        addSubview(label)
        addSubview(textView)
        textView.delegate = self
        textView.textAlignment = .right
        textView.textColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        textView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        textView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textView.textColor = UIColor.gray
        return false
    }
}
