//
//  ViewController.swift
//  BreathingAnimation
//
//  Created by MacMini6 on 16/05/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!{
        didSet {
            mainView.layer.cornerRadius  = 25
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
  

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            startBreathingAnimation()
        }
    
        // MARK: - Setup circular shapes
        private func setupViews() {
            // Make the background view circular
            bgView.layer.cornerRadius = bgView.frame.size.width / 2
            bgView.clipsToBounds = true

            // Make the image view circular
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
        }

        // MARK: - Breathing animation with ease-in both ways
        private func startBreathingAnimation() {
            let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            keyframeAnimation.values = [0.8, 1.1, 0.8]
            keyframeAnimation.keyTimes = [0, 0.5, 1]
            keyframeAnimation.timingFunctions = [
                CAMediaTimingFunction(name: .easeIn),
                CAMediaTimingFunction(name: .easeIn)
            ]
            keyframeAnimation.duration = 1.5
            keyframeAnimation.repeatCount = .infinity

            bgView.layer.add(keyframeAnimation, forKey: "breathingEaseIn")
        }

}
