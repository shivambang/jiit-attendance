//
//  TimeTCell.swift
//  TT
//
//  Created by Shivam Bang on 02/08/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class TimeTCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    let goView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 16)
        view.textAlignment = .center
        //view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let timeView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.darkGray
        view.textAlignment = .center
        //view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let placeView: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor.darkGray
        view.textAlignment = .center
        //view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        //label.backgroundColor = UIColor.lightGray
        return label
    }()

    let rtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.textAlignment = .right
        //label.backgroundColor = UIColor.lightGray
        return label
    }()
    
    let subtitleTextView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 12)
        textView.textColor = UIColor.darkGray
        //textView.backgroundColor = UIColor.lightGray
        return textView
    }()
    
    var data: CellData? {
        didSet{
            timeView.text = data?.time
            placeView.text = data?.place
            titleLabel.text = Constants.subjects?[(data?.sub!)!]
            subtitleTextView.text = data?.type
            goView.text = Constants.attd?[(data?.sub)!]
            let temp = Float(goView.text!) ?? 0
            if temp < 60{
                goView.textColor = UIColor.init(red: 255 / 255, green: 59 / 255, blue: 48 / 255, alpha: 1)
            }
            else if temp < 75{
                goView.textColor = UIColor.init(red: 255 / 255, green: 204 / 255, blue: 0 / 255, alpha: 1)
            }
            else{
                goView.textColor = UIColor.init(red: 76 / 255, green: 217 / 255, blue: 100 / 255, alpha: 1)
            }
            
        }
    }
    func setupViews() {
        addSubview(goView)
        addSubview(timeView)
        addSubview(placeView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(rtitleLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(60)]-8-[v1]-8-[v2(50)]-16-|", views: timeView, titleLabel, goView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-12-[v0(20)]-2-[v1(20)]-12-|", views: timeView, placeView)
        
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: goView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 12))
        //height constraint
        addConstraint(NSLayoutConstraint(item: goView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40))
        
        addConstraint(NSLayoutConstraint(item: placeView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 16))
        addConstraint(NSLayoutConstraint(item: placeView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 60))

        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 12))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: timeView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: goView, attribute: .left, multiplier: 1, constant: -8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: placeView, attribute: .right, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 125))
        
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .right, relatedBy: .equal, toItem: goView, attribute: .left, multiplier: 1, constant: -8))
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        addConstraint(NSLayoutConstraint(item: rtitleLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 75))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
