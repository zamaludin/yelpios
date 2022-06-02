//
//  PlaceListVC.swift
//  testios42race
//
//  Created by Zamaludin Abdulah on 27/05/22.
//

import UIKit

class PlaceListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchByBtn: UIButton!
    @IBOutlet weak var sortByBtn: UIButton!
    
    var isSearch = false
    private var searchTimer: Timer?
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTableView()
        self.viewModel.getPlcaces(term: self.viewModel.term)
        self.setupBinders()
        self.searchBar.delegate = self
        self.title = "Place Finder"
    }
    
    private func setupBinders() {
        viewModel.error.bind({ error in
            if let error = error {
                print(error)
            }
        })
        viewModel.places.bind({[weak self] places in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        })
        viewModel.selectedSearchByBtnTitle.bind({[weak self] selected in
            if !(selected?.isEmpty ?? true) {
                self?.searchByBtn.setTitle("Search by | \(selected ?? "")", for: .normal)
            }
            
        })
        
        viewModel.selectedSortByBtnTitle.bind({[weak self] selected in
            if !(selected?.isEmpty ?? true) {
                self?.sortByBtn.setTitle("Sort by | \(selected ?? "")", for: .normal)
            }
            
        })
    }
    @IBAction func didTapSearchBy(_ sender: Any) {
        self.viewModel.showSearchBy(vc: self)
    }
    @IBAction func didTapSortBy(_ sender: Any) {
        self.viewModel.showSortBy(vc: self)
    }
}
extension PlaceListVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.places.value?.count == 0 ? 1 : self.viewModel.places.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.tableView(tableView, placeCellForRowAt: indexPath)
    }
    
    
    func configureTableView() {
        
        self.tableView.register(UINib(nibName: "PlaceListCell", bundle: self.nibBundle), forCellReuseIdentifier: "PlaceListCell")
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PlacesWireframe.performPlaceDetail(caller: self, data: ["id" : self.viewModel.places.value?[indexPath.row].id ?? ""])
    }
}

extension PlaceListVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.viewModel.term = self.searchBar.text ?? ""
        }
    }
    
}
