//
//  OverridenLoginViewController.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/4/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import UIKit
import ILLoginKit

class OverridenLoginViewController: LoginViewController {
    
    override func viewDidLoad() {
        configuration = Settings.defaultLoginConfig
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
