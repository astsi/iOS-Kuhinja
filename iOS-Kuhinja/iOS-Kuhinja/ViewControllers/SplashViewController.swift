//
//  SplashViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//


import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var loadingProgressView: UIProgressView!
}

// MARK: - Lifecycles
 
extension SplashViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        navigate(self: self)
    }
}

// MARK: - Actions

extension SplashViewController {
    
    func startTimer(){
        var timePassed = 1
        let totalTime = 3
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if timePassed <= totalTime {
                self.loadingProgressView.progress = Float(timePassed) / Float(totalTime)
                timePassed += 1
            } else {
                Timer.invalidate()
            }
        }
    }
}

// MARK: - Navigation

extension SplashViewController {
    
    func navigate(self: UIViewController) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.1) {
            self.performSegue(withIdentifier: K.goToExplore, sender: nil)
        }
    }
    
}
