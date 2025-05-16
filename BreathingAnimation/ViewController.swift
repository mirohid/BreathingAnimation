//
//  ViewController.swift
//  BreathingAnimation
//
//  Created by MacMini6 on 16/05/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Circular background view with custom sky color and breathing animation
    private let breathingView: UIView = {
        let view = UIView()
        
        // Setting background color using rgba(45, 127, 144, 0.2)
        view.backgroundColor = UIColor(red: 45/255, green: 127/255, blue: 144/255, alpha: 0.2)
        
        // Enabling Auto Layout
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Circular ImageView placed on top of the background view
    private let circularImageView: UIImageView = {
        let imageView = UIImageView()
        // Replace "myPTstar" with your image name in Assets.xcassets
        imageView.image = UIImage(named: "myPTstar")
        // Set image scaling mode and clipping
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        // Enabling Auto Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set main background color
        view.backgroundColor = .white
        // Setup subviews and layout
        setupViews()
        // Start breathing animation on background view
        startBreathingAnimation()
    }
    // MARK: - Setup layout and circular shape of views
    private func setupViews() {
        // Add both views to the main view
        view.addSubview(breathingView)
        view.addSubview(circularImageView)
        // Size for the background circle
        let size: CGFloat = 200
        // Center the background view and set size
        NSLayoutConstraint.activate([
            breathingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            breathingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            breathingView.widthAnchor.constraint(equalToConstant: size),
            breathingView.heightAnchor.constraint(equalToConstant: size)
        ])
        // Make the background view perfectly circular
        breathingView.layer.cornerRadius = size / 2
        // Place the image view centered inside the background view and slightly smaller
        NSLayoutConstraint.activate([
            circularImageView.centerXAnchor.constraint(equalTo: breathingView.centerXAnchor),
            circularImageView.centerYAnchor.constraint(equalTo: breathingView.centerYAnchor),
            circularImageView.widthAnchor.constraint(equalToConstant: size - 40),
            circularImageView.heightAnchor.constraint(equalToConstant: size - 40)
        ])

        // Make the image view circular too
        circularImageView.layer.cornerRadius = (size - 40) / 2
    }

    // MARK: - Breathing animation with ease-in both ways
    private func startBreathingAnimation() {
        // Use keyframe animation to control scaling and timing precisely
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")

        // Animation scales the view: normal size → slightly bigger → back to normal
        keyframeAnimation.values = [1.0, 1.1, 1.0]

        // Key times define when each value occurs in the animation timeline
        keyframeAnimation.keyTimes = [0, 0.5, 1]

        // Timing functions: ease-in for both segments (scale up and scale down)
        keyframeAnimation.timingFunctions = [
            CAMediaTimingFunction(name: .easeIn), // Start to mid (grow)
            CAMediaTimingFunction(name: .easeIn)  // Mid to end (shrink)
        ]

        // Total duration of one full breathing cycle
        keyframeAnimation.duration = 1.5

        // Repeat animation forever
        keyframeAnimation.repeatCount = .infinity

        // Add animation to the background layer
        breathingView.layer.add(keyframeAnimation, forKey: "breathingEaseIn")
    }

}
