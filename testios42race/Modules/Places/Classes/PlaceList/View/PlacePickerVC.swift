//
//  PlaceSearchByPickerVC.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 02/06/22.
//

import UIKit

class PlacePickerVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var listSearchBy = ["Name", "Address", "Cuisine"]
    var listSort = ["Distance", "Rating"]
    var isSearchBy = true
    var didSelectRow : ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
    }
}
extension PlacePickerVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.isSearchBy ? self.listSearchBy.count : self.listSort.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerCell", for: indexPath)
        cell.textLabel?.text = self.isSearchBy ? self.listSearchBy[indexPath.row] : self.listSort[indexPath.row]
        return cell
    }
    
    
    func configureTableView() {
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectRow?(self.isSearchBy ? self.listSearchBy[indexPath.row] : self.listSort[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
}
