//
//  ViewController.swift
//  CALayerDemo
//
//  Created by Ivan Akulov on 07/12/2016.
//  Copyright © 2016 Ivan Akulov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
  
  var shapeLayer: CAShapeLayer! {
    didSet {
      shapeLayer.lineWidth = 20
      shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
      shapeLayer.fillColor = nil
      shapeLayer.strokeEnd = 1
      let color = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
      shapeLayer.strokeColor = color
    }
  }
  
  var overShapeLayer: CAShapeLayer! {
    didSet {
      overShapeLayer.lineWidth = 20
      overShapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "round")
      overShapeLayer.fillColor = nil
      overShapeLayer.strokeEnd = 0
      let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
      overShapeLayer.strokeColor = color
    }
  }
  
  var gradientLayer: CAGradientLayer! {
    didSet {
      gradientLayer.startPoint = CGPoint(x: 0, y: 0)
      gradientLayer.endPoint = CGPoint(x: 0, y: 1)
      
      let startColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).cgColor
      let endColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
      gradientLayer.colors = [startColor, endColor]
//      gradientLayer.locations = [0, 0.2, 1]
    }
  }
  
  @IBOutlet weak var imageView: UIImageView! {
    didSet {
      imageView.layer.cornerRadius = imageView.frame.size.height / 2
      imageView.layer.masksToBounds = true
      
      let borderColor = UIColor.white
      imageView.layer.borderColor = borderColor.cgColor
      imageView.layer.borderWidth = 10
    }
  }
  
  @IBOutlet weak var button: UIButton! {
    didSet {
      button.layer.shadowOffset = CGSize(width: 0, height: 5)
      button.layer.shadowOpacity = 0.5
      button.layer.shadowRadius = 10
    }
  }
  
  override func viewDidLayoutSubviews() {
    gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
    
    configShape(shapeLayer)
    configShape(overShapeLayer)
  }
  
  func configShape(_ shapeLayer: CAShapeLayer) {
    shapeLayer.frame = view.bounds
    let path = UIBezierPath()
    path.move(to: CGPoint(x: self.view.frame.width / 2 - 120, y: self.view.frame.height / 2))
    path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 120, y: self.view.frame.height / 2))
    shapeLayer.path = path.cgPath
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    gradientLayer = CAGradientLayer()
    view.layer.insertSublayer(gradientLayer, at: 0)
    
    shapeLayer = CAShapeLayer()
    view.layer.addSublayer(shapeLayer)
    
    overShapeLayer = CAShapeLayer()
    view.layer.addSublayer(overShapeLayer)
  }
  
  @IBAction func tapped(_ button: UIButton) {
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.toValue = 1
    animation.duration = 2
    
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    animation.fillMode = CAMediaTimingFillMode.both
    animation.isRemovedOnCompletion = false
    
    animation.delegate = self
    overShapeLayer.add(animation, forKey: nil)
  }
  
  func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
    performSegue(withIdentifier: "showSecondScreen", sender: self)
  }
}

