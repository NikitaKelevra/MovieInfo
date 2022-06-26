//
//  ViewController.swift
//  MovieInfo
//
//  Created by Сперанский Никита on 20.06.2022.
//

import UIKit

class ViewController: UIViewController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.shared.fetch()

        
    }

   

}


