//
//  ViewController.swift
//  Floating Menu
//
//  Created by Faisal on 01/03/19.
//  Copyright © 2019 Faisal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func ShowMenu(_ sender: Any) {
        let menuView = FloatingMenuView(frame: UIScreen.main.bounds)
        menuView.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(menuView)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.transitionCrossDissolve], animations: {
            menuView.alpha = 1
        }, completion: nil)
    }

}

