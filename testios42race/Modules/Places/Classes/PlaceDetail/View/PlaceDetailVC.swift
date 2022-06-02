//
//  PlaceDetailVC.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 29/05/22.
//

import UIKit

class PlaceDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var hoursOfOperationLbl: UILabel!
    @IBOutlet weak var placeImg: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    var viewModel = PlaceDetailViewModel()
    var idPlace = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBinders()
        self.viewModel.getPlaceDetail(id: self.idPlace)
    }
    private func setupBinders() {
        viewModel.error.bind({ error in
            if let error = error {
                print(error)
            }
        })
        viewModel.place.bind({[weak self] model in
            DispatchQueue.main.async {
                self?.nameLbl.text = model?.name
                self?.addressLbl.text = model?.address
                self?.hoursOfOperationLbl.text = model?.hoursOfOperation
                self?.placeImg.downloaded(from: model?.img ?? "", contentMode: .scaleAspectFill)
                self?.ratingLbl.text = "\(model?.rating ?? 0)"
                self?.phoneLbl.text = model?.phone
            }
        })
    }
}
