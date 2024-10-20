//
//  TableViewCell.swift
//  PermissionSetting
//
//  Created by Mohammad Masud Rana on 15/10/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let cellIdentifire = "TableViewCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var switchValue: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib{
        return UINib(nibName: cellIdentifire, bundle: nil)
    }
    
    func populateData() {
        
    }
}
