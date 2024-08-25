//
//  CustomViewExtensions.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//

import SwiftUI

extension View {
    /**
     Adds a corner radius to specific corners of a view.

     - Parameters:
       - radius: The radius of the rounded corners.
       - corners: The specific corners to be rounded. This can be any combination of `.topLeft`, `.topRight`, `.bottomLeft`, and `.bottomRight`.

     - Returns: A view with the specified corners rounded.

     This modifier allows for greater flexibility when rounding corners by enabling the rounding of specific corners instead of all corners.
     */
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    /**
     Creates a path in the specified rectangle with rounded corners.

     - Parameter rect: The rectangle in which to draw the path.

     - Returns: A `Path` object representing the rounded corners within the given rectangle.

     This struct is used in conjunction with the `cornerRadius(_:corners:)` modifier to apply rounded corners to specific corners of a view.
     */
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
