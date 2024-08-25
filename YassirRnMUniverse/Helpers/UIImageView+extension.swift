//
//  UIImageView+extension.swift
//  YassirRnMUniverse
//
//  Created by Rotimi Joshua on 25/08/2024.
//
import UIKit

// Global image cache to store downloaded images and prevent redundant network requests
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    /**
     Loads an image from a given URL string.

     - Parameter urlString: The string representation of the image URL.

     This method first checks the `imageCache` for a cached image. If a cached image exists, it is immediately set to the `UIImageView`. If not, it attempts to download the image asynchronously. Once downloaded, the image is cached and set to the `UIImageView`.

     - Important: Ensure that `urlString` is a valid URL string.
     */
    func loadImage(from urlString: String) {
        // Check if the image is already cached
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }

        // Validate the URL
        guard let url = URL(string: urlString) else {
            return
        }

        // Fetch the image data asynchronously
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // Cache the downloaded image
                imageCache.setObject(image, forKey: urlString as NSString)
                // Set the image on the main thread
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

extension UIImage {
    /**
     Creates a `UIImage` with a solid color.

     - Parameters:
       - color: The color of the image.
       - size: The size of the image. The default size is 1x1.

     - Returns: An optional `UIImage` instance with the specified color and size.

     This convenience initializer is useful for creating images that act as color placeholders or backgrounds. It uses Core Graphics to draw a rectangle filled with the specified color.
     */
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
