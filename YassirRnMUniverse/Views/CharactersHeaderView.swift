//
//  CharactersHeaderView.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import UIKit

class CharactersHeaderView: UIView {

    let filterControl: UISegmentedControl = {
        let control = UISegmentedControl(items: Constants.filterItems)
        control.selectedSegmentIndex = 0

        // Set up the border and rounded corners
        control.backgroundColor = .clear
        control.layer.cornerRadius = 18
        control.layer.masksToBounds = true
        control.layer.borderWidth = 1
        control.layer.borderColor = Constants.borderColor.cgColor

        // Set font and color for normal state
        control.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.black
        ], for: .normal)

        // Set font and color for selected state
        control.setTitleTextAttributes([
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ], for: .selected)

        // Customize the appearance for selected segments
        if #available(iOS 14.0, *) {
            control.setBackgroundImage(UIImage(color: .clear, size: CGSize(width: 1, height: 32)), for: .normal, barMetrics: .default)
            control.setBackgroundImage(UIImage(color: Constants.primaryPurpleColor, size: CGSize(width: 1, height: 32)), for: .selected, barMetrics: .default)
        }

        // Remove divider between segments
        control.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)

        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(filterControl)

        NSLayoutConstraint.activate([
            filterControl.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            filterControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            filterControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            filterControl.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
