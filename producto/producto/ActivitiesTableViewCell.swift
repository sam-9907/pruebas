//
//  ActivitiesTableViewCell.swift
//  producto
//
//  Created by macbook on 11/28/18.
//  Copyright © 2018 potato. All rights reserved.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var actividad: UILabel!
    
    @IBOutlet weak var mes: UILabel!
    
    @IBOutlet weak var día: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
