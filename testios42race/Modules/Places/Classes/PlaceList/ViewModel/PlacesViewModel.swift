//
//  PlacesViewModel.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 27/05/22.
//

import Foundation
import UIKit
final class LoginViewModel {
    var places : ObservableObject<[PlaceModel]?> = ObservableObject(nil)
    var error : ObservableObject<String?> = ObservableObject(nil)
    var totalPlace = 0
    var selectedSearchByBtnTitle : ObservableObject<String?> = ObservableObject(nil)
    var selectedSortByBtnTitle : ObservableObject<String?> = ObservableObject(nil)
    var lat = "1.3111593"
    var lon = "103.861736"
    var term = "" {
        didSet {
            self.getPlcaces(term: self.term)
        }
    }
    func getPlcaces(term : String) {
        PlacesNetwork.getBusinessesList(parameters: self.buildParameter(term: term), onSuccess: {[weak self](responses) in
            var result = [PlaceModel]()
            self?.totalPlace = responses.total
            for data in responses.businesses {
                result.append(PlaceModel(id: data.id ?? "0", name: data.name, address: "\(data.location.address1) \(data.location.address2 ?? "")", imageUrl: data.imageURL ))
            }
            self?.places.value = result
        }, onFailure: {[weak self](err) in
            self?.error.value = err
        })
    }
    
    func buildParameter(term : String) -> [String : String] {
        var parameter = [String : String]()
        switch self.selectedSearchByBtnTitle.value?.lowercased() {
        case "name" :
            parameter["term"] = term
        case "address" :
            parameter["location"] = term
        case "cuisine" :
            parameter["categories"] = term
        default :
            parameter["term"] = term
        }
        switch self.selectedSortByBtnTitle.value?.lowercased() {
        case "distance" :
            parameter["sort_by"] = "distance"
        case "rating" :
            parameter["sort_by"] = "rating"
        default:
            parameter["sort_by"] = "distance"
        }
        if self.selectedSortByBtnTitle.value?.lowercased() != "address" {
            parameter["latitude"] = self.lat
            parameter["longitude"] = self.lon
        }
        return parameter
    }
    
    func tableView(_ tableView: UITableView, placeCellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceListCell", for: indexPath) as? PlaceListCell ?? PlaceListCell()
        if self.totalPlace > 0 {
            if let data = self.places.value?[indexPath.row] {
                cell.setupCell(data: data)
            }
        } else {
            cell.placeNameLbl.text = "Not found"
            cell.placeImg.isHidden = true
            cell.placeAddressLbl.isHidden = true
        }
        return cell
    }
    
    func showSearchBy(vc : UIViewController){
        PlacesWireframe.presentPlacePicker(caller: vc, data: ["isSearchBy" : true, "didSelectRow" : {( selected : String) in
            self.selectedSearchByBtnTitle.value = selected
            self.getPlcaces(term: self.term)
        }])
    }
    func showSortBy(vc : UIViewController){
        PlacesWireframe.presentPlacePicker(caller: vc, data: ["isSearchBy" : false, "didSelectRow" : {( selected : String) in
            self.selectedSortByBtnTitle.value = selected
            self.getPlcaces(term: self.term)
        }])
    }
}
