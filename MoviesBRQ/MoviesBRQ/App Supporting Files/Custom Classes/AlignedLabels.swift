//
//  AlignedLabels.swift
//  MoviesBRQ
//
//  Created by Marcos Amorim Rossi de Carvalho on 30/06/21.
//

import Foundation
import UIKit

@IBDesignable class BottomAlignedLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawText(in rect: CGRect) {

        guard text != nil else {
            return super.drawText(in: rect)
        }

        let height = self.sizeThatFits(rect.size).height
        let y = rect.origin.y + rect.height - height
        super.drawText(in: CGRect(x: 0, y: y, width: rect.width, height: height))
    }
}

@IBDesignable class TopAlignedLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawText(in rect: CGRect) {

        guard text != nil else {
            return super.drawText(in: rect)
        }

        let height = self.sizeThatFits(rect.size).height
        super.drawText(in: CGRect(x: 0, y: 0, width: rect.width, height: height))
    }
}
