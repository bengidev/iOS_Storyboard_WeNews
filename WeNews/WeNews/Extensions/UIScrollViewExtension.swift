//
//  UIScrollViewExtension.swift
//  WeNews
//
//  Created by ENB Mac Mini M1 on 05/12/24.
//

import UIKit

// MARK: - ReuseableView

protocol ReuseableView: AnyObject {}

// MARK: - NibLoadableView

protocol NibLoadableView: AnyObject {}

extension ReuseableView {
    static var reuseID: String { return "\(self)" }
}

extension NibLoadableView {
    static var nibName: String { return "\(self)" }
}

// MARK: - UITableViewCell + ReuseableView, NibLoadableView

extension UITableViewCell: ReuseableView, NibLoadableView {}

// MARK: - UICollectionViewCell + ReuseableView, NibLoadableView

extension UICollectionViewCell: ReuseableView, NibLoadableView {}

// MARK: - UITableViewHeaderFooterView + ReuseableView, NibLoadableView

extension UITableViewHeaderFooterView: ReuseableView, NibLoadableView {}

extension UITableView {
    func dequeueResuableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseID, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseID)")
        }
        return cell
    }

    func dequeueResuableHeaderFooter<T: UITableViewHeaderFooterView>() -> T {
        guard let headerFooter = dequeueReusableHeaderFooterView(withIdentifier: T.reuseID) as? T else {
            fatalError("Could not dequeue header footer view with identifier: \(T.reuseID)")
        }
        return headerFooter
    }

    func register<T: ReuseableView & NibLoadableView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: T.reuseID)
    }

    func registerHeaderFooter<T: ReuseableView & NibLoadableView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forHeaderFooterViewReuseIdentifier: T.reuseID)
    }
}
