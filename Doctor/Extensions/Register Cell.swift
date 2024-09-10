//
//  Register Cell.swift
//  Doctor
//
//  Created by Minh Nguỵn on 9/9/24.
//

import Foundation
import UIKit

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadable {
    static var nib: UINib { get }
}

extension NibLoadable where Self: UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
   

typealias SummaryMethod = Reusable & NibLoadable


extension UITableView {

    // Register a UITableViewCell conforming to Reusable using class
    func registerClass<Cell: UITableViewCell & SummaryMethod>(cellType: Cell.Type) {
        self.register(cellType, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    // Register a UITableViewCell conforming to Reusable and NibLoadable using Nib
    func registerNib<Cell: UITableViewCell & SummaryMethod>(cellType: Cell.Type) {
        self.register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    // Dequeue a UITableViewCell conforming to Reusable
    func dequeue<Cell: UITableViewCell & Reusable>(cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Error: Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        return cell
    }
}
extension UICollectionView {
    
    // Register UICollectionViewCell using nib
    func registerNib<Cell: UICollectionViewCell & SummaryMethod>(cellType: Cell.Type) {
        self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    // Register UICollectionViewCell using class
    func registerClass<Cell: UICollectionViewCell & Reusable>(cellType: Cell.Type) {
        self.register(cellType, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    // Dequeue UICollectionViewCell
    func dequeue<Cell: UICollectionViewCell & Reusable>(cellType: Cell.Type, for indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? Cell else {
            fatalError("Error: Could not dequeue cell with identifier: \(cellType.reuseIdentifier)")
        }
        return cell
    }
}
