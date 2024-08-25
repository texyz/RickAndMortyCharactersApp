//
//  Constants.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//
import UIKit

struct Constants {
    static let baseURL = "https://rickandmortyapi.com/api"
    static let characterEndpoint = "/character/"
    static let characterCellIdentifier = "CharacterCell"

    // Filter control items
    static let filterItems = ["All", "Alive", "Dead", "Unknown"]

    // Status colors using RGB values
    static let statusColors: [String: UIColor] = [
        "Alive": UIColor(red: 255/255, green: 230/255, blue: 235/255, alpha: 1),
        "Dead": UIColor(red: 232/255, green: 246/255, blue: 252/255, alpha: 1),
        "unknown": UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    ]

    // Cell height
    static let cellHeight: CGFloat = 100

    // Custom colors
    static let primaryPurpleColor = UIColor(red: 32/255, green: 0/255, blue: 80/255, alpha: 1)
    static let backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    static let selectionColor = UIColor(red: 216/255, green: 191/255, blue: 216/255, alpha: 1)
    static let borderColor = UIColor(red: 208/255, green: 210/255, blue: 215/255, alpha: 1)

    // Navigation bar large title color (with alpha)
    static func largeTitleTextColor(withAlpha alpha: CGFloat) -> UIColor {
        return UIColor(red: 32/255, green: 0/255, blue: 80/255, alpha: alpha)
    }
}
