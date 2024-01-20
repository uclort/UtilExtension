//
//  GWTableViewExtension.swift
//  UtilExtension
//
//  Created by 侯猛 on 2022/8/6.
//

import Foundation

public extension UclortExtensionVariableUtil where Util: UITableView {
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = util.dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = util.dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type) -> T {
        guard let headerFooterView = util.dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: name)), make sure the view is registered with table view")
        }
        return headerFooterView
    }

    func register<T: UITableViewHeaderFooterView>(nib: UINib?, withHeaderFooterViewClass name: T.Type) {
        util.register(nib, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith name: T.Type) {
        util.register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        util.register(T.self, forCellReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewCell>(nib: UINib?, withCellClass name: T.Type) {
        util.register(nib, forCellReuseIdentifier: String(describing: name))
    }

    func register<T: UITableViewCell>(nibWithCellClass name: T.Type, at bundleClass: AnyClass? = nil) {
        let identifier = String(describing: name)
        var bundle: Bundle?

        if let bundleName = bundleClass {
            var path = Bundle(for: bundleName).resourcePath ?? ""
            let typeString = NSStringFromClass(bundleName)
            let bundleString = typeString.components(separatedBy: ".").first ?? ""
            path.append("/\(bundleString).bundle")
            bundle = Bundle(path: path)
        }

        util.register(UINib(nibName: identifier, bundle: bundle), forCellReuseIdentifier: identifier)
    }

    /// 检查 indexPath 在 tableView 中是否有效
    func isValidIndexPath(_ indexPath: IndexPath) -> Bool {
        indexPath.section >= 0 &&
            indexPath.row >= 0 &&
            indexPath.section < util.numberOfSections &&
            indexPath.row < util.numberOfRows(inSection: indexPath.section)
    }

    /// 安全滚动到指定下标
    func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard indexPath.section < util.numberOfSections else { return }
        guard indexPath.row < util.numberOfRows(inSection: indexPath.section) else { return }
        util.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
}

public extension UclortExtensionVariableUtil where Util: UITableViewHeaderFooterView {
    /// 背景颜色
    var backgroundViewColor: UIColor? {
        get { util.backgroundView?.backgroundColor }
        set {
            if util.backgroundView == nil {
                util.backgroundView = UIView()
            }
            util.backgroundView?.backgroundColor = newValue
        }
    }
}

open class NiblessTableViewCell: UITableViewCell {
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
}

open class NiblessTableViewHeaderFooterView: UITableViewHeaderFooterView {
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable, message: "Instantiating this view from a nib is not supported.")
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Instantiating this view from a nib is not supported.")
    }
}

