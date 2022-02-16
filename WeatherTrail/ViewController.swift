//
//  ViewController.swift
//  WeatherTrail
//
//  Created by comviva on 05/02/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let bg = UIImageView(frame: UIScreen.main.bounds)
        bg.image = UIImage(named: "background1")
        bg.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.insertSubview(bg, at: 0)
        // Do any additional setup after loading the view.
    }


}

