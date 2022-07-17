//
//  DateTimeViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 16.07.2022.
//

import UIKit

class DateTimeViewController: UIViewController {

    @IBOutlet weak var timetable: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UIButton!
    var selectedStation: Station?
    var viewModel: DateTimeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.prompt = selectedStation?.stationName
        timetable?.isScrollEnabled = true
        setCurrentDate()
        datePicker.isHidden = true
        if let selectedStation = selectedStation {
            viewModel = DateTimeViewModel(station: selectedStation)
            Task{
                await viewModel?.getOccupiedTime()
            }
        }
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        dateLabel.titleLabel?.text = formatDate(date: sender.date)
    }
    
    @IBAction func openDatePicker(_ sender: Any) {
        datePicker.isHidden = false
    }
    
    func setCurrentDate(){
        let date = Date()
        dateLabel.titleLabel?.text = formatDate(date: date)
        viewModel?.selectedDate = date
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        datePicker.minimumDate = date
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: date)
    }
}

extension DateTimeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
