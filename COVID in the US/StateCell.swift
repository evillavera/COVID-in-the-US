//
//  StateCell.swift
//  COVID in the US
//
//  Created by Erik Villavera on 1/21/21.
//

import UIKit

class StateCell: UITableViewCell {

    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var diffCases: UILabel!
    @IBOutlet weak var diffDeaths: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
