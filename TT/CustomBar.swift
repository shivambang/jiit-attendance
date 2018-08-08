//
//  CustomBar.swift
//  TT
//
//  Created by Shivam Bang on 29/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit

class CustomBar: UINavigationBar{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 50)
    }
}
