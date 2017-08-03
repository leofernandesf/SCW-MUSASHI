//
//  MyCellCollectionViewCell.swift
//  SCW-MUSASHI
//
//  Created by leo on 09/11/16.
//  Copyright © 2016 tap4. All rights reserved.
//

import UIKit

class MyCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override var isSelected: Bool {
        didSet{
            lbTitle.textColor = isSelected ? UIColor.green.verde : UIColor.white.withAlphaComponent(0.6)
            self.backgroundColor = isSelected ?  UIColor.black.backGround : UIColor.clear
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            lbTitle.textColor = isHighlighted ? UIColor.green.verde : UIColor.white.withAlphaComponent(0.6)
            self.backgroundColor = isHighlighted ?  UIColor.black.backGround : UIColor.clear
        }
    }
    
}
