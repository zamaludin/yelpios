//
//  PlaceListCell.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 28/05/22.
//

import UIKit

class PlaceListCell: UITableViewCell {

    @IBOutlet weak var placeNameLbl: UILabel!
    @IBOutlet weak var placeAddressLbl: UILabel!
    @IBOutlet weak var placeImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(data : PlaceModel) {
        self.placeNameLbl.text = data.name
        self.placeAddressLbl.text = data.address
        self.placeImg.downloaded(from: data.imageUrl, contentMode: .scaleAspectFill)
    }
}
