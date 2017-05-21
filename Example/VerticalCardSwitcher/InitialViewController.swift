//
//  InitialViewController.swift
//  VerticalCardSwitcher
//
//  Created by Matija Kruljac on 21/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class InitialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Examples"
    }
    
    @IBAction func example1ButtonTapped(_ sender: Any) {
        guard let firstViewController = storyboard?.instantiateViewController(withIdentifier: "FirstViewController") else { return }
        navigationController?.pushViewController(firstViewController, animated: true)
    }
    
    @IBAction func example2ButtonTapped(_ sender: Any) {
        guard let secondViewController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") else { return }
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
