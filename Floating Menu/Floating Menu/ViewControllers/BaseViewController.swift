//
//  BaseViewController.swift
//  Floating Menu
//
//  Created by Faisal on 01/03/19.
//  Copyright © 2019 Faisal. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupFloatingButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func setupFloatingButton(){
        let btnCustom = CustomButtonView(frame: CGRect(x: view.bounds.maxX - 100, y: view.bounds.maxY - 100, width: 70, height: 70))
        btnCustom.controllerIdentifier = Constants.VC_TAG_VALUE.TWO_TAG
        view.addSubview(btnCustom)
    }

}
