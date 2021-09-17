//
//  StationTimetableSectionHeaderView.swift
//  FlixBus
//
//  Created by Anil Goktas on 9/17/21.
//

import UIKit

final class StationTimetableSectionHeaderView: UITableViewHeaderFooterView {

    // MARK: - IBOutlets
    
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: StationTimetableSectionHeaderViewModel? {
        didSet { configure() }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        if #available(iOS 14.0, *) {
            var backgroundConfiguration = UIBackgroundConfiguration.listPlainHeaderFooter()
            backgroundConfiguration.backgroundColor = R.color.green(compatibleWith: nil)
            self.backgroundConfiguration = backgroundConfiguration
        } else {
            backgroundView?.backgroundColor = R.color.green(compatibleWith: nil)
        }
    }
    
    // MARK: - Configuration
    
    private func configure() {
        guard let viewModel = viewModel else {
            configureUsingPlaceholders()
            return
        }
        
        dateLabel.text = viewModel.dateString
    }
    
    private func configureUsingPlaceholders() {
        dateLabel.text = "Date"
    }
    
}
