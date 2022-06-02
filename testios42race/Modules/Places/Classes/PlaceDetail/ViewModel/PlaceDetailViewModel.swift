//
//  PlaceDetailViewModel.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 29/05/22.
//

import Foundation
final class PlaceDetailViewModel {
    var place : ObservableObject<PlaceDetailModel?> = ObservableObject(nil)
    var error : ObservableObject<String?> = ObservableObject(nil)
    
    func getPlaceDetail(id : String) {
        PlacesNetwork.getBusinessesDetail(id: id, onSuccess: { [weak self] (responses) in
            var address = ""
            for addr in responses.location?.displayAddress ?? [] {
                address += addr + " "
            }
            var hoursOfOperation = ""
            let newline = CharacterSet.newlines.allCharacters[0]
            if let hours = responses.hours?[0] {
                for hour in hours.hourOpen {
                    hoursOfOperation += self?.hoursDataToInfo(data: hour) ?? ""
                    hoursOfOperation += "\(newline)"
                }
            }
            self?.place.value = PlaceDetailModel(id: responses.id ?? "", name: responses.name ?? "", address: address, img: responses.imageURL ?? "", hoursOfOperation: hoursOfOperation, rating: responses.rating, phone: responses.displayPhone ?? "")
            
        }, onFailure: {[weak self](err) in
            self?.error.value = err
        })
    }
    
    func hoursDataToInfo(data : DAOPlaceDetailOpen) -> String{
        return("\(self.intToDay(dayInInt: data.day)) \(data.start.prefix(2)):\(data.start.suffix(2)) - \(data.end.prefix(2)):\(data.end.suffix(2)) ")
    }
    
    func intToDay(dayInInt : Int) -> String {
        switch dayInInt {
        case 0 :
            return "Sunday"
        case 1 :
            return "Monday"
        case 2 :
            return "Tuesday"
        case 3 :
            return "Wednesday"
        case 4 :
            return "Thursday"
        case 5 :
            return "Friday"
        default :
            return "Saturday"
        }
    }
}
