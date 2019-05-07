//
//  SecondViewController.swift
//  CALayerDemo
//
//  Created by Ivan Akulov on 07/12/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, CAAnimationDelegate {
  
  var circleShapeLayer: CAShapeLayer! {
    didSet {
      circleShapeLayer.lineWidth = 7
      circleShapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
      circleShapeLayer.fillColor = nil
      circleShapeLayer.strokeEnd = 1
      let color = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1).cgColor
      circleShapeLayer.strokeColor = color
    }
  }
  
  var overCircleShapeLayer: CAShapeLayer! {
    didSet {
      overCircleShapeLayer.lineWidth = 7
      overCircleShapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
      overCircleShapeLayer.fillColor = nil
      overCircleShapeLayer.strokeEnd = 0
      let color = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
      overCircleShapeLayer.strokeColor = color
    }
  }
  
  var gradientLayer: CAGradientLayer! {
    didSet {
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 1, y: 1)
      
      gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor, UIColor.orange.cgColor]
      gradientLayer.locations = [0, 0.2, 0.8]
    }
  }
  
  @IBOutlet weak var imageView: UIImageView! {
    didSet {
      imageView.layer.cornerRadius = imageView.frame.size.height / 2
      imageView.layer.masksToBounds = true
      
      let borderColor = UIColor.white
      imageView.layer.borderColor = borderColor.cgColor
      imageView.layer.borderWidth = 7
    }
  }
  
  @IBOutlet weak var button: UIButton! {
    didSet {
      button.layer.shadowOffset = CGSize(width: 0, height: 5)
      button.layer.shadowOpacity = 0.5
      button.layer.shadowRadius = 5
    }
  }
  
  override func viewDidLayoutSubviews() {
    gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    
    configCircleShape(circleShapeLayer)
    configCircleShape(overCircleShapeLayer)
  }
  
  func configCircleShape(_ circleShapeLayer: CAShapeLayer) {
    circleShapeLayer.frame = view.bounds
    let path = UIBezierPath(arcCenter: CGPoint(x: self.view.frame.width / 2,
                                               y: self.view.frame.height / 2),
                            radius: CGFloat(imageView.frame.size.height / 2),
                            startAngle: CGFloat(0),
                            endAngle: CGFloat.pi * 2,
                            clockwise: true)
    circleShapeLayer.path = path.cgPath
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gradientLayer = CAGradientLayer()
    view.layer.insertSublayer(gradientLayer, at: 0)
    
    circleShapeLayer = CAShapeLayer()
    view.layer.addSublayer(circleShapeLayer)
    
    overCircleShapeLayer = CAShapeLayer()
    view.layer.addSublayer(overCircleShapeLayer)
  }
  
  var refAnimation: CABasicAnimation!
  
  @IBAction func tapped(_ button: UIButton) {
//    overCircleShapeLayer.strokeEnd += 0.2
    
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = 2
    
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    animation.fillMode = CAMediaTimingFillMode.both
    
    animation.delegate = self
    overCircleShapeLayer.add(animation, forKey: nil)
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    let ac = UIAlertController(title: "You've got the cup", message: "Congratulations!", preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
      self.overCircleShapeLayer.strokeEnd = 0
    }
    ac.addAction(okAction)
    present(ac, animated: true, completion: nil)
  }
}
