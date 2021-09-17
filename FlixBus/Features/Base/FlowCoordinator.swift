//
//  FlowCoordinator.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import Foundation
import UIKit

// sourcery: AutoMockable
protocol FlowCoordinating {
    var rootViewController: UIViewController? { get }
    
    func configure()
}

final class FlowCoordinator: FlowCoordinating {
    
    // MARK: - Properties
    
    private var navigationController: BaseNavigationController?
    private var stationsViewController: StationsViewController?
    
    var rootViewController: UIViewController? { navigationController }
    
    // MARK: - Life Cycle
    
    func configure() {
        let viewModel = StationsViewModel()
        let stationsViewController = StationsViewController.instantiate(viewModel: viewModel)
        stationsViewController.didSelectStation = { [weak self] station in
            self?.showStation(station)
        }
        self.stationsViewController = stationsViewController
        
        navigationController = BaseNavigationController(rootViewController: stationsViewController)
    }
    
    // MARK: - Station
    
    private func showStation(_ station: Station) {
        let repository = StationTimetableRepository(station: station)
        let viewModel = StationViewModel(repository: repository)
        let viewController = StationViewController.instantiate(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}
