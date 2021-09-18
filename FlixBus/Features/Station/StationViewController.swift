//
//  StationViewController.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import UIKit

final class StationViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private(set) var scheduleTypeSegmentedControl: UISegmentedControl!
    @IBOutlet private(set) var tableView: UITableView!
    
    // MARK: - Properties
    
    private(set) var viewModel: StationViewModelProtocol!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureScheduleTypeSegmentedControl()
        title = viewModel.title
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.configureDataSource()
    }
    
    // MARK: - Configurations
    
    private func configureScheduleTypeSegmentedControl() {
        for scheduleType in StationViewModel.ScheduleType.allCases {
            scheduleTypeSegmentedControl.setTitle(
                scheduleType.title,
                forSegmentAt: scheduleType.rawValue
            )
        }
        scheduleTypeSegmentedControl.selectedSegmentIndex = viewModel.scheduleType.rawValue
    }
    
}

// MARK: - IBActions

extension StationViewController {
    
    @IBAction private func scheduleTypeDidChange(_ sender: Any) {
        let index = scheduleTypeSegmentedControl.selectedSegmentIndex
        guard let scheduleType = StationViewModel.ScheduleType(rawValue: index) else {
            fatalError("Unknown schedule type")
        }
        viewModel.scheduleType = scheduleType
    }
    
}

// MARK: - UITableViewDataSource

extension StationViewController: UITableViewDataSource {
    
    private func configureTableView() {
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.register(R.nib.stationTimetableElementTableViewCell)
        tableView.registerHeaderFooterView(R.nib.stationTimetableSectionHeaderView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.stationTimetableElementTableViewCell,
            for: indexPath
        )!
        cell.viewModel = viewModel.cellViewModel(indexPath: indexPath)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension StationViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: R.reuseIdentifier.stationTimetableSectionHeaderView
        )
        headerView?.viewModel = viewModel.headerViewModel(section: section)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
}

// MARK: - Instantiate

extension StationViewController {
    
    static func instantiate(viewModel: StationViewModelProtocol) -> StationViewController {
        let viewController = R.storyboard.main.stationViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}
