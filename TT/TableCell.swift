//
//  TableCell.swift
//  TT
//
//  Created by Shivam Bang on 27/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import Foundation

import UIKit

class TableCell: UITableViewCell {
    
    let statusView: UIView = {
        let imageView = UIView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    let rtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    var data: [String:String]? {
        didSet{
            subtitleLabel.text = data?["F"]
            let date: String = (data?["D"])!
            titleLabel.textColor = UIColor.gray
            titleLabel.font = UIFont.systemFont(ofSize: 14)
            titleLabel.text = date.substring(to: date.index(date.startIndex, offsetBy: 10))
            rtitleLabel.textColor = UIColor.gray
            rtitleLabel.font = UIFont.systemFont(ofSize: 14)
            rtitleLabel.text = date.substring(from: date.index(date.startIndex, offsetBy: 10))
            var color = UIColor.gray.cgColor
            if data?["S"] == "Present"{
                color = UIColor.init(red: 76 / 255, green: 217 / 255, blue: 100 / 255, alpha: 1).cgColor
            }
            else{
                color = UIColor.init(red: 255 / 255, green: 59 / 255, blue: 48 / 255, alpha: 1).cgColor
            }
            
            let trackLayer = CAShapeLayer()
            
            let cPath = UIBezierPath(arcCenter: CGPoint(x: 15, y: 15), radius: 5, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
            trackLayer.path = cPath.cgPath
            trackLayer.lineWidth = 5
            trackLayer.fillColor = color
            trackLayer.lineCap = kCALineCapRound
            if statusView.layer.sublayers != nil{
                for sl in statusView.layer.sublayers!{
                    sl.removeFromSuperlayer()
                }
            }
            statusView.layer.addSublayer(trackLayer)

        }
    }
    
    
    func setupViews() {
        addSubview(statusView)
        addSubview(titleLabel)
        addSubview(rtitleLabel)
        addSubview(subtitleLabel)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-[v1]-8-[v2(30)]-16-|", views: titleLabel, rtitleLabel, statusView)
        addConstraintsWithFormat(format: "H:|-20-[v0]-8-[v1(30)]-16-|", views: subtitleLabel, statusView)
        addConstraintsWithFormat(format: "V:|-12-[v0]-8-[v1]-12-|", views: titleLabel, subtitleLabel)
        
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: statusView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 22))
        //height constraint
        addConstraint(NSLayoutConstraint(item: statusView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 12))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 150))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))

        //top constraint
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 12))
        //right constraint
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .right, relatedBy: .equal, toItem: statusView, attribute: .left, multiplier: 1, constant: -8))
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 75))
        //height constraint
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 5))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 25))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleLabel, attribute: .right, relatedBy: .equal, toItem: statusView, attribute: .left, multiplier: 1, constant: -8))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
