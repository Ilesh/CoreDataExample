//
//  TransactionCell.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 11/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet var lblAumount: UILabel!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblNote: UILabel!
    @IBOutlet var viewBG : UIView!
    var isIncome : Bool! {
        didSet {
            if isIncome {
                self.viewBG.layer.borderColor = Theme.color.primaryTheme.cgColor
                lblAumount.textColor = Theme.color.primaryTheme
            }else{
                self.viewBG.layer.borderColor = Theme.color.primaryRed.cgColor
                lblAumount.textColor = Theme.color.primaryRed
            }
            self.viewBG.layer.borderWidth = 1.0
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
