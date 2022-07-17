//
//  CitiesViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 13.07.2022.
//

import UIKit

class CitiesViewController: UIViewController {
    var viewModel: CitiesViewModel?
    var cities: Cities?
    @IBOutlet weak var searchCity: CustomSearchBar!
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var notFoundStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loadingVC = LoadingViewController()

        loadingVC.modalPresentationStyle = .overCurrentContext

        loadingVC.modalTransitionStyle = .crossDissolve
               
        //present(loadingVC, animated: true, completion: nil)
        
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesTableView.backgroundView = nil
        citiesTableView.backgroundColor = .clear
        
        searchCity.delegate = self
        
        viewModel = CitiesViewModel()
        
        viewModel?.cities.bind({ [weak self] cts in
            if let self = self {
                self.cities = cts
                self.showValues()
            }
        })
    }
    
    func showValues(){
        if cities != nil && !cities!.isEmpty{
            DispatchQueue.main.async {
                self.citiesTableView.reloadData()
                //self.presentingViewController?.dismiss(animated: true)
            }
        }
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .clear
        cell.textLabel?.text = cities?[indexPath.row]
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let city = cities?[indexPath.row] {
            viewModel?.navigateToStations(city: city, context: self)
        }
    }
}

extension CitiesViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        cities = searchText.isEmpty ? viewModel?.cities.value : viewModel?.cities.value.filter({ city -> Bool in
            return city.lowercased().contains(searchText.lowercased())
        })
        doFoundInTableOperations(searchText: searchText)
        citiesTableView.reloadData()
    }
    
    func doFoundInTableOperations(searchText: String){
        citiesTableView.isHidden = !searchText.isEmpty && (cities == nil || cities!.isEmpty)
        notFoundStack.isHidden = !citiesTableView.isHidden
        let color = searchText.isEmpty ? UIColor.white : cities == nil || cities!.isEmpty ? UIColor.red : UIColor.green
        searchCity.searchTextField.layer.borderColor = color.cgColor
    }
}
