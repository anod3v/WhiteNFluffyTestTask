//
//  RoundCornersImageView.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 04/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class RoundCornersImageView: UIImageView {
    
    private(set) var radius: CGFloat = 0
    
    init(frame: CGRect, cornerRadius: CGFloat) {
        super.init(frame: frame)
        self.radius = cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        needsUpdateConstraints()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentMode = .scaleAspectFill
        self.radius = self.bounds.size.width/2.0
        layer.cornerRadius = self.radius
        clipsToBounds = true
    }

}

