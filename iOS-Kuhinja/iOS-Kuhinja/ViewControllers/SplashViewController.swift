//
//  SplashViewController.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 19.4.22..
//


import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var loadingProgressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        startTimer()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5.1) { //TODO: napraviti ekstenziju da obavlja ovu f-ju, sa parametrom self
            self.performSegue(withIdentifier: "GoToExplore", sender: nil)
            
        }
    }
    

    func startTimer(){
            
        var timePassed = 1
        let totalTime = 5
        
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
