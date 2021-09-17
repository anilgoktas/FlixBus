//
//  StationTimetableElementTableViewCell.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import UIKit

final class StationTimetableElementTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var lineAndDirectionLabel: UILabel!
    @IBOutlet private weak var briefRouteLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: StationTimetableElementTableCellViewModel? {
        didSet { configure() }
    }
    
    // MARK: - Configuration
    
    private func configure() {
        guard let viewModel = viewModel else {
            configureUsingPlaceholders()
            return
        }
        
        timeLabel.text = viewModel.timeString
        lineAndDirectionLabel.text = viewModel.lineAndDirectionString
        briefRouteLabel.text = viewModel.briefRouteString
    }
    
    private func configureUsingPlaceholders() {
        timeLabel.text = "Time"
        lineAndDirectionLabel.text = "Line and direction"
        briefRouteLabel.text = "Brief Route"
    }
    
}
