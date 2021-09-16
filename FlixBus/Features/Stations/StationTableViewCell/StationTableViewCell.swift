//
//  StationTableViewCell.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/16/21.
//

import UIKit

final class StationTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: StationTableCellViewModel? {
        didSet { configure() }
    }
    
    // MARK: - Configuration
    
    private func configure() {
        guard let viewModel = viewModel else {
            configureUsingPlaceholders()
            return
        }
        
        nameLabel.text = viewModel.name
    }
    
    private func configureUsingPlaceholders() {
        nameLabel.text = "Station Name"
    }
    
}
