//
//  SecondViewController.swift
//  ios-animation
//
//  Created by Chris on 2018/11/7.
//  Copyright © 2018 Chris. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
     let pushTransitionDelegate = PushTansitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        self.view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            
            pushTransitionDelegate.interactive = true
            self.navigationController?.delegate = pushTransitionDelegate
            self.navigationController?.popViewController(animated: true)
        }else {
            pushTransitionDelegate.handlePan(recognizer: recognizer)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
