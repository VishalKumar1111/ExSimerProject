//
//  ViewController.swift
//  ExBlinkProject
//
//  Created by RLogixxTraining on 30/01/24.
//

import UIKit
extension UIColor {
    class func random() -> UIColor {
        let rand = { (max: CGFloat) -> CGFloat in
            let rnd = CGFloat(arc4random()) / CGFloat(UInt32.max)
            return rnd * max
        }

        return UIColor(red: rand(1.0), green: rand(1.0), blue: rand(1.0), alpha: 1.0)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
          super.viewDidLoad()

          let makeView = { (text: String) -> UIView in
              let view = UIView()
              view.backgroundColor = UIColor.random()
              view.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
              self.view.addSubview(view)

              let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
              label.text = text
              label.textAlignment = .center
              view.addSubview(label)

              return view
          }

          let imageViews = [
              makeView("Hello How Are You "),
              makeView("THIS IS THE VALUE A"),
              makeView("THIS IS THE VALUE OF B"),
              makeView("THIS IS THE VALUE OF C"),
              makeView("THIS IS THE ALUE OF D"),
              makeView("THIS IS THE VALUE OF E")
          ]

          let locationForView = { (angle: CGFloat, center: CGPoint, radius: CGFloat) -> CGPoint in
              let angle = angle * CGFloat.pi / 180.0
              return CGPoint(x: center.x - radius * cos(angle), y: center.y + radius * sin(angle))
          }

          for i in 0..<imageViews.count {
              let center = self.view.center
              let radius = ((150.0 + imageViews[i].bounds.size.width) / 2.0)
              let count = imageViews.count
              imageViews[i].center = locationForView(((360.0 / CGFloat(count)) * CGFloat(i)) + 90.0, center, radius)
          }

          self.animate(views: imageViews.reversed(), duration: 3.0, intervalDelay: 0.5)
      }

      private func animate(views: [UIView], duration: TimeInterval, intervalDelay: TimeInterval) {
          CATransaction.begin()
          CATransaction.setCompletionBlock {
              print("COMPLETED ALL ANIMATIONS")
          }

          var delay: TimeInterval = 0.0
          let interval = duration / TimeInterval(views.count)

          for view in views {
              let label = view.subviews.first as! UILabel
              let colour = view.backgroundColor
              let transform = view.transform

              UIView.animate(withDuration: interval, delay: delay, options: [.curveEaseIn], animations: {
                  view.backgroundColor = UIColor.red
                  view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                  label.alpha = 0.0 // Toggle label visibility
              }, completion: { (finished) in
                  UIView.animate(withDuration: interval, delay: 0.0, options: [.curveEaseIn], animations: {
                      view.backgroundColor = colour
                      view.transform = transform
                      label.alpha = 1.0 // Toggle label visibility
                  }, completion: { (finished) in
                  })
              })

              delay += (interval * 2.0) + intervalDelay
          }

          CATransaction.commit()
      }

      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
  }
