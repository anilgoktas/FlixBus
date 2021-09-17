//
//  BaseNavigationController.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    // MARK: - Configurations
    
    private func configureNavigationBar() {
        let greenColor = R.color.green(compatibleWith: nil)
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = greenColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = nil
        
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        if #available(iOS 15.0, *) {
            navigationBar.compactScrollEdgeAppearance = appearance
        }
    }
    
}
