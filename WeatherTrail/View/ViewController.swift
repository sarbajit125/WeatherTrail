//
//  ViewController.swift
//  WeatherTrail
//
//  Created by comviva on 05/02/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomebg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let bg = UIImageView(frame: UIScreen.main.bounds)
        bg.image = UIImage(named: "first")
        bg.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(bg, at: 0)
        // Do any additional setup after loading the view.
    }


}

