//
//  imgTest.swift
//  WeatherTrail
//
//  Created by comviva on 06/02/22.
//

import UIKit

class imgTest: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bg = UIImageView(frame: UIScreen.main.bounds)
        bg.image = UIImage(named: "background1")
        bg.contentMode = UIView.ContentMode.scaleAspectFit
        self.view.insertSubview(bg, at: 0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
