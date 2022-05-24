//
//  String+UIImage.swift
//  iOS-Kuhinja
//
//  Created by Anastasija on 24.5.22..
//

import UIKit

public extension String {
    
    func loadImage() -> UIImage {
        do {
            guard let url = URL(string: self) else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
            
        } catch {
            print ("Error getting image")
        }
        return UIImage()
    }
}
