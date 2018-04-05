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
        configuration = Settings.defaultLoginConfig // configure before calling super
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
