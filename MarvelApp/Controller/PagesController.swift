//
//  ViewController.swift
//  MarvelApp
//
//  Created by Suraj Kodre on 22/10/18.
//  Copyright © 2018 Suraj Kodre. All rights reserved.
//

import UIKit

class PagesController: UIViewController {
    @IBOutlet weak var screenName: UILabel!
    
    var screen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let screen = screen {
            screenName.text = screen
        }
    }
}
