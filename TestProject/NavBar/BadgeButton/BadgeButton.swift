//
//  SwiftyBadgeButton.swift
//  SwiftyBadgeButton
//
//  Created by Raphael Cruzeiro on 04/06/16.
//  Copyright © 2016 Raphael Cruzeiro. All rights reserved.
//

import Foundation
import UIKit

public class BadgeButton: UIButton {

    public let badgeLabel = UILabel()

    public var animated = true

    public var badgeInset = UIEdgeInsets.zero {
        didSet {
            setSize()
        }
    }

    public var badgeSize = CGSize(width: 15, height: 15) {
        didSet {
            badgeLabel.frame.size = badgeSize
            layoutSubviews()
        }
    }

    public var badgeText: String? {
        didSet {
            // changing this variable name for clarity.
            let isTextAString: Bool = Int(badgeText ?? "") == nil
            
            badgeLabel.isHidden = isTextAString
            badgeLabel.text = badgeText
            
            setSize()
            
            if animated {
                UIView.animate(withDuration: 0.5,
                               delay: 0.2,
                               usingSpringWithDamping: 0.3,
                               initialSpringVelocity: 0.3,
                               options: UIView.AnimationOptions()) {
                    
                    self.badgeLabel.layer.transform = CATransform3DMakeScale(1, 1, 1)
                    
                    // You can just do this `if` statement inside the animation block
                    
                    if isTextAString {
                        self.badgeLabel.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
                    }
                    
                } completion: { (_) in }
            }
        }
    }

    public var badgeBackgroundColor = UIColor.red {
        didSet {
            badgeLabel.backgroundColor = badgeBackgroundColor
        }
    }

    public var badgeFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            badgeLabel.font = badgeFont
        }
    }

    public var badgeTextColor = UIColor.white {
        didSet {
            badgeLabel.textColor = badgeTextColor
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public init() {
        super.init(frame: CGRect.zero)
        setup()
    }

    private func setup() {
        addSubview(badgeLabel)

        badgeLabel.frame.size = badgeSize
        badgeLabel.clipsToBounds = true
        badgeLabel.isHidden = true
        badgeLabel.textAlignment = .center
        badgeLabel.minimumScaleFactor = 0.5
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.font = badgeFont
        badgeLabel.textColor = badgeTextColor
    }

    private func setSize() {
        if badgeText != nil {
            badgeLabel.sizeToFit()
            let padding = max(badgeSize.height - badgeLabel.frame.size.height, 0)

            badgeLabel.frame.size = CGSize(width: max(badgeLabel.bounds.size.width + padding, 15),
                                           height: badgeSize.height)
        }
        let width = badgeLabel.frame.size.width - badgeInset.left + badgeInset.right
        let height = badgeLabel.frame.size.height - badgeInset.top + badgeInset.bottom

        let xPos = (bounds.size.width - badgeLabel.bounds.size.width/1.3) + badgeInset.left
        let yPos = (-badgeLabel.bounds.size.height / 3) + badgeInset.top

        badgeLabel.frame = CGRect(x: xPos, y: yPos, width: width, height: height)
        badgeLabel.layer.cornerRadius = height / 2
        badgeLabel.layoutIfNeeded()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setSize()
    }

}
