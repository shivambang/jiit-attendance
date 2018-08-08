//
//  Cell.swift
//  TT
//
//  Created by Shivam Bang on 26/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var data: CellData? {
        didSet{
            titleLabel.text = data?.subject
            subtitleTextView.textColor = UIColor.gray
            subtitleTextView.font = UIFont.systemFont(ofSize: 12)
            for sv in pAView.subviews{
                sv.removeFromSuperview()
            }
            if pAView.layer.sublayers != nil {
            for sl in pAView.layer.sublayers!{
                sl.removeFromSuperlayer()
            }
            }
            if data?.attd?["O"] != ""{
                let angle: String = (data?.attd?["O"])!
                Circle().draw(angle: CGFloat(Float(angle) ?? 0), view: pAView)
                subtitleTextView.text = "Lecture: \((data?.attd?["L"])!)%       Tutorial: \(((data?.attd?["T"])!))%"
            }
            else{
                let angle: String = (data?.attd?["P"])!
                Circle().draw(angle: CGFloat(Float(angle) ?? 0), view: pAView)
                subtitleTextView.text = "Practical: \((data?.attd?["P"])!)%"
            }
            let go = UIBezierPath()
            go.move(to: CGPoint(x: 25, y: 20))
            go.addLine(to: CGPoint(x: 30, y: 25))
            go.addLine(to: CGPoint(x: 25, y: 30))
            let button = CAShapeLayer()
            button.path = go.cgPath
            button.lineWidth = 2
            button.strokeColor = UIColor.lightGray.cgColor
            button.fillColor = UIColor.clear.cgColor
            if goView.layer.sublayers != nil{
            for sl in goView.layer.sublayers!{
                sl.removeFromSuperlayer()
            }
            }
            goView.layer.addSublayer(button)
        }
    }
    
    let goView: UIView = {
        let imageView = UIView()
        return imageView
    }()
    
    let pAView: UIView = {
        let view = UIView()
        return view
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    func setupViews() {
        addSubview(goView)
        addSubview(separatorView)
        addSubview(pAView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(60)]-8-[v1]-8-[v2(50)]-16-|", views: pAView, titleLabel, goView)
        
        //vertical constraints
        addConstraintsWithFormat(format: "V:|-15-[v0(60)]-14-[v1(1)]|", views: pAView, separatorView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorView)
        

        //top constraint
        addConstraint(NSLayoutConstraint(item: goView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 22))
       //height constraint
        addConstraint(NSLayoutConstraint(item: goView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 50))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 15))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: pAView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: goView, attribute: .left, multiplier: 1, constant: -8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: pAView, attribute: .right, multiplier: 1, constant: 8))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: goView, attribute: .left, multiplier: 1, constant: -8))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
