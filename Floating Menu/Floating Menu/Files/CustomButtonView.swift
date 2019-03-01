//
//  CustomButtonView.swift
//  EnvoyFloatingMenu
//
//  Created by Faisal on 20/07/18.
//  Copyright © 2018 Faisal. All rights reserved.
//

import UIKit

class CustomButtonView: UIButton {

    var controllerIdentifier = Int()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup()
    {
        self.setImage(#imageLiteral(resourceName: "Avengers-Icon"), for: .normal)
        self.addTarget(self, action: #selector(showAlertView), for: .touchUpInside)
    }
    
    @objc func showAlertView()
    {
        let menuView = FloatingMenuView(frame: UIScreen.main.bounds)
        menuView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(menuView)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve], animations: {
            menuView.alpha = 1
        }, completion: nil)
    }
}
