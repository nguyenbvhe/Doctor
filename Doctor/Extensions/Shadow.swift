//
//  Shadow.swift
//  BSGNProject
//
//  Created by Linh Thai on 20/08/2024.
//

import Foundation
import UIKit
extension UIViewController {
    func applyShadow(to cell: UITableViewCell, offset: CGSize = CGSize(width: 0, height: 4), radius: CGFloat = 8, opacity: Float = 0.1) {
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = offset
        cell.layer.shadowRadius = radius
        cell.layer.shadowOpacity = opacity
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
    }
    
    
}



