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
    
    private(set) var rootViewController: UIViewController?
    
    private var stationsViewController: StationsViewController?
    
    // MARK: - Life Cycle
    
    func configure() {
        let viewModel = StationsViewModel()
        let stationsViewController = StationsViewController.instantiate(viewModel: viewModel)
        stationsViewController.didSelectStation = { [weak self] station in
            self?.showStation(station)
        }
        self.stationsViewController = stationsViewController
        
        rootViewController = BaseNavigationController(rootViewController: stationsViewController)
    }
    
    // MARK: - Station
    
    private func showStation(_ station: Station) {
        print("will show station")
    }
    
}
