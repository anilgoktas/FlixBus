//
//  StationsViewController.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import UIKit

final class StationsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak private(set) var tableView: UITableView!
    
    // MARK: - Properties
    
    private(set) var viewModel: StationsViewModelProtocol!
    var didSelectStation: ((Station) -> Void)?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
}

// MARK: - UITableViewDataSource

extension StationsViewController: UITableViewDataSource {
    
    private func configureTableView() {
        tableView.register(R.nib.stationTableViewCell)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.stationTableViewCell,
            for: indexPath
        )!
        cell.viewModel = viewModel.cellViewModel(at: indexPath.row)
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension StationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = viewModel.station(at: indexPath.row)
        didSelectStation?(station)
    }
    
}

// MARK: - Instantiate

extension StationsViewController {
    
    static func instantiate(
        viewModel: StationsViewModelProtocol
    ) -> StationsViewController {
        let viewController = R.storyboard.main.stationsViewController()!
        viewController.viewModel = viewModel
        return viewController
    }
    
}
