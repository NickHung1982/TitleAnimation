//
//  SecondViewController.swift
//  scrollingAnimation
//
//  Created by Nick on 8/21/18.
//  Copyright © 2018 NickOwn. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var helloLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func clickChangeButton(_ sender: Any) {
        helloLabel.text = "Bonjour"
    }
    
}
