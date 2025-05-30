//
//  SecondViewController.swift
//  BreathingAnimation
//
//  Created by MacMini6 on 30/05/25.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var animatingView: UIView!
    @IBOutlet weak var centerImageView: UIImageView!

    @IBOutlet weak var startAnimation: UIButton!
    @IBOutlet weak var stopAnimation: UIButton!

    private let progressLayer = CAShapeLayer()
    private let backgroundLayer = CAShapeLayer()
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupProgressRing()
        //animateProgressLoop()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupProgressPath()
    }

    @IBAction func startAnimationTAP(_ sender: UIButton) {
        if !isAnimating {
            animateProgressLoop()
            isAnimating = true
        }
    }

    @IBAction func stopAnimationTAP(_ sender: Any) {
        progressLayer.removeAnimation(forKey: "progressAnimation")
        isAnimating = false
    }

    private func setupProgressRing() {
        backgroundLayer.strokeColor = UIColor.clear.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = 6
        backgroundLayer.lineCap = .round
        animatingView.layer.addSublayer(backgroundLayer)

        progressLayer.strokeColor =
            UIColor(named: "bgColor")?.cgColor ?? UIColor.systemBlue.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 6
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        animatingView.layer.addSublayer(progressLayer)
    }

    private func setupProgressPath() {
        let center = CGPoint(
            x: animatingView.bounds.midX,
            y: animatingView.bounds.midY
        )
        let padding: CGFloat = 4
        let radius =
            min(animatingView.bounds.width, animatingView.bounds.height) / 2
            - padding - (backgroundLayer.lineWidth / 2)

        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat.pi / 2,
            endAngle: CGFloat.pi * 1.5,
            clockwise: true
        )

        backgroundLayer.path = circularPath.cgPath
        progressLayer.path = circularPath.cgPath
    }

    private func animateProgressLoop() {
        progressLayer.strokeEnd = 0

        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        animation.autoreverses = false
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        progressLayer.add(animation, forKey: "progressAnimation")
    }
}
