//
//  StationsViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 14.07.2022.
//

import UIKit
import TTGTags

class StationsViewController: UIViewController {
    @IBOutlet weak var stationsSearchBar: CustomSearchBar!
    @IBOutlet weak var stationsTableView: UITableView!
    @IBOutlet weak var stationsCountLabel: UILabel!
    var selectedCity: String?
    var viewModel: StationsViewModel?
    var stations: Stations?
    @IBOutlet weak var filterView: GradientView!
    @IBOutlet weak var deviceTags: UIView!
    @IBOutlet weak var socketTags: UIView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var serviceTags: UIView!
    let deviceCV = TTGTextTagCollectionView()
    let socketCV = TTGTextTagCollectionView()
    let serviceCV = TTGTextTagCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stationsTableView.delegate = self
        stationsTableView.dataSource = self
        stationsSearchBar.delegate = self
        deviceCV.delegate = self
        socketCV.delegate = self
        serviceCV.delegate = self
        
        createCollectionView(collectionView: deviceCV, inView: deviceTags, labels: ChargeType.allCases.map { $0.rawValue })
        createCollectionView(collectionView: socketCV, inView: socketTags, labels: SocketType.allCases.map { $0.rawValue })
        createCollectionView(collectionView: serviceCV, inView: serviceTags, labels: Service.allCases.map { $0.rawValue })
        
        if let city = selectedCity{
            viewModel = StationsViewModel(selectedCity: city)
            Task{
                await viewModel?.getStations()
            }
        }
        
        viewModel?.stations.bind({ [weak self] sts in
            if let self = self{
                self.stations = sts
                self.reloadTable()
            }
        })
        filterView.isHidden = true
    }
    
    @IBAction func filterShow(_ sender: Any) {
        filterView.isHidden = !filterView.isHidden
    }
    
    @IBAction func sliderChange(_ sender: UISlider) {
        viewModel?.changeKm(value: sender.value)
    }
    
    func reloadTable(){
        DispatchQueue.main.async {
            self.stationsTableView.reloadData()
            self.stationsCountLabel.text = "Displaying \(self.stations?.count ?? 0) results for the city of \(self.selectedCity ?? "City")"
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        deviceCV.frame = CGRect(x: 0, y: 8, width: 400, height: 50)
        serviceCV.frame = CGRect(x: 0, y: 8, width: 400, height: 50)
        socketCV.frame = CGRect(x: 0, y: 8, width: 400, height: 50)
    }
    
    @IBAction func applyFilter(_ sender: Any) {
        viewModel?.filterStations()
        filterView.isHidden = true
    }
}

extension StationsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationTableViewCell") as! StationTableViewCell
        if let station = stations?[indexPath.row]{
            cell.locationLabel.text = station.stationName
            setCellValues(station, cell)
        }
        cell.layoutMargins = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0)
        return cell
    }
    
    fileprivate func setCellValues(_ station: Station, _ cell: StationTableViewCell) {
        if let count = station.socketCount, let occupied = station.occupiedSocketCount{
            cell.socketCount.text = String(Int(count) - Int(occupied))
        }
        if let sockets = station.sockets{
            let charge = sockets.allSatisfy({ socket in
                return socket.chargeType == ChargeType.ac
            }) ? Charge.ac : sockets.allSatisfy({ socket in
                return socket.chargeType == ChargeType.dc
            }) ? Charge.dc : Charge.acdc
            switch charge {
            case .ac:
                cell.currentImage.image = UIImage(named: "AC")
            case .dc:
                cell.currentImage.image = UIImage(named: "DC")
            case .acdc:
                cell.currentImage.image = UIImage(named: "AC-DC")
            }
        }
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = UIColor(red: 68/255, green: 73/255, blue: 84/255, alpha: 1)
        if let km = station.distanceInKM{
            cell.kwLabel.text = String(format: "%.2f", km) + " km"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let station = stations?[indexPath.row]{
            viewModel?.navigateToDateTime(station: station, context: self)
        }
    }
}

enum Charge{
    case ac, dc, acdc
}

extension StationsViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.stations = searchText.isEmpty ? self.viewModel?.stations.value : self.viewModel?.stations.value.filter({ station in
            return station.stationName?.lowercased().contains(searchText.lowercased()) ?? false
        })
        let color = searchText.isEmpty ? UIColor.white : stations == nil || stations!.isEmpty ? UIColor.red : UIColor.green
        stationsSearchBar.searchTextField.layer.borderColor = color.cgColor
        self.stationsTableView.reloadData()
    }
}

extension StationsViewController: TTGTextTagCollectionViewDelegate{
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        if let content = tag.content as? TTGTextTagStringContent{
            viewModel?.selectTag(tag: content.text)
        }
    }
    
    func createCollectionView(collectionView: TTGTextTagCollectionView, inView: UIView, labels: [String]){
        let config = TTGTextTagStyle()
        config.borderColor = .white
        config.borderWidth = 1
        config.backgroundColor = .clear
        config.cornerRadius = 15
        config.extraSpace = CGSize(width: 30, height: 10)
        
        let selectedConfig = TTGTextTagStyle()
        selectedConfig.borderColor = .green
        selectedConfig.borderWidth = 1
        selectedConfig.backgroundColor = .black
        selectedConfig.cornerRadius = 15
        selectedConfig.extraSpace = CGSize(width: 30, height: 10)
        
        let tags = labels.map { device in
            return TTGTextTag(content: TTGTextTagStringContent(text: device, textFont: .systemFont(ofSize: 17), textColor: .white), style: config, selectedContent: TTGTextTagStringContent(text: device, textFont: .systemFont(ofSize: 17), textColor: .white), selectedStyle: selectedConfig)
        }
        
        collectionView.add(tags)
        inView.addSubview(collectionView)
    }
}
