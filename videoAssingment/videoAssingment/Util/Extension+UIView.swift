//
//  Extension+UIView.swift
//  videoAssingment
//
//  Created by Abhinav on 15/11/24.
//

import UIKit

extension UIButton {
    func showAndHide() {
        self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        self.isHidden = false

        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [.calculationModeCubic], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3) {
                self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }, completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView.animate(withDuration: 0.3) {
                    self.alpha = 0.0
                } completion: { _ in
                    self.isHidden = true
                    self.alpha = 1.0 
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


extension String {

    func formattedDateComponents() -> (dayMonth: String, year: String)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"

        guard let date = dateFormatter.date(from: self) else {
            return nil
        }

        let dayMonthFormatter = DateFormatter()
        dayMonthFormatter.dateFormat = "d MMM"
        let dayMonth = dayMonthFormatter.string(from: date)

        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy" 
        let year = yearFormatter.string(from: date)

        return (dayMonth, year)
    }
}
