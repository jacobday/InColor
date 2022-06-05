//
//  SavedItemTableViewCell.swift
//  InColor
//
//  Created by Jacob Day on 4/16/22.
//
// Evan Japundza, evjapund - Eli Cohen, cohenelj - Jacob Day, day6 ---------- In Color ---------- 5/6/2022

import UIKit
import CoreData

class SavedItemTableViewCell: UITableViewCell {
    
    var shareClosure: ((SavedItemTableViewCell) -> ())
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var drawingNumber: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    @IBAction func shareImage(_ sender: Any) {
        shareClosure(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.shareClosure = {_ in}
        super.init(coder: aDecoder)
    }
}
