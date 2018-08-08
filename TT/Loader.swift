//
//  Loader.swift
//  TT
//
//  Created by Shivam Bang on 27/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class Loader: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Loading"
        navigationItem.hidesBackButton = true
        view.backgroundColor = UIColor.white
        let act = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        act.frame = CGRect(x: view.frame.width / 2 - 50, y: view.frame.height / 2 - 50, width: 100, height: 100)
        act.startAnimating()
        view.addSubview(act)
    }
    
}
