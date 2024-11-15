//
//  Extension+UIView.swift
//  videoAssingment
//
//  Created by Abhinav on 15/11/24.
//

import UIKit

extension UIButton {
    func showAndHide() {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1) // Start small
        self.isHidden = false // Make sure button is visible

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeCubic], animations: {
            // Step 1: Grow quickly
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            // Step 2: Shrink slightly
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }, completion: { _ in
            // Step 3: Hide button after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1-second delay before hiding
                UIView.animate(withDuration: 0.3) {
                    self.alpha = 0.0
                } completion: { _ in
                    self.isHidden = true
                    self.alpha = 1.0 // Reset alpha for next time
                }
            }
        })
    }
}


extension UIButton {
    func setUnderlinedTitle(_ title: String, for state: UIControl.State = .normal) {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .foregroundColor: self.titleColor(for: state) ?? UIColor.white
        ]
        let attributedString = NSAttributedString(string: title, attributes: attributes)
        self.setAttributedTitle(attributedString, for: state)
    }
}
