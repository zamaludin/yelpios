//
//  PlacesWireframe.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 28/05/22.
//

import Foundation
import UIKit
public struct PlacesWireframe {
    
    public static func initPlaceList( data: [String: Any?])-> UINavigationController {
        let storyboard = UIStoryboard(name: "PlaceList", bundle: Bundle.main)
        let nav = storyboard.instantiateInitialViewController() as? UINavigationController ?? UINavigationController()
        return nav
    }
    
    public static func presentPlacePicker(caller : UIViewController, data: [String: Any?]) {
        let storyboard = UIStoryboard(name: "PlacePicker", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as! PlacePickerVC
        vc.isSearchBy = data["isSearchBy"] as? Bool ?? true
        vc.didSelectRow = data["didSelectRow"] as? ((String) -> Void) ?? nil
        caller.present(vc, animated: true, completion: nil)
    }
    
    public static func performPlaceDetail(caller: UIViewController, data: [String: Any]) {
        let storyboard = UIStoryboard(name: "PlaceDetail", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as? PlaceDetailVC ?? PlaceDetailVC()
        vc.idPlace = data["id"] as? String ?? ""
        caller.navigationController?.pushViewController(vc, animated: true)
    }
}
