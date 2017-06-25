//
//  ViewController.swift
//  TableViewShrink
//
//  Created by James Valaitis on 24/06/2017.
//  Copyright © 2017 &Beyond. All rights reserved.
//

import UIKit

//  MARK: View Controller
final class ViewController: UIViewController {
    //  MARK: Constant
    fileprivate let maximumOffset: CGFloat = 120.0
    fileprivate let cellReuseIdentifier = "Cell"
    fileprivate let data = [
        "Oh dear.",
        "What the fuck",
        "have we here?",
        "These motherfuckers,",
        "all thorn no rose.",
        "Egads, what a bad dream;",
        "better not sleep.",
        "Take a No-Doz,",
        "do some blow.",
        "Oh shit.",
        "What the hell",
        "have we done?",
        "It's alive,",
        "and it's hungry as fuck."
    ]
    fileprivate var previousOffset:CGPoint = .zero
    //  MARK: Properties
    @IBOutlet fileprivate weak var topTableViewConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leadingTableViewConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var trailingTableViewConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var tableView: UITableView!
}
//  MARK: View Lifecycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        var inset = tableView.contentInset
        //        inset.top = maximumOffset
        //        tableView.contentInset = inset
        //
        //        var offset = tableView.contentOffset
        //        offset.y = -maximumOffset
        //        tableView.contentOffset = offset
        //        tableView.scrollsToTop = true
        //        tableView.bounces = false
    }
    
}
//  MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let title = data[indexPath.row]
        cell.textLabel?.text = title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}
//  MARK: UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        tableView.bounces = true
        if topTableViewConstraint.constant == 0 && scrollView.contentOffset.y > 0 {
            previousOffset = scrollView.contentOffset
            return
        }
        
        let diff = scrollView.contentOffset.y - previousOffset.y
        
        if topTableViewConstraint.constant == maximumOffset {
            tableView.bounces = false
        }
        
        topTableViewConstraint.constant -= diff
        
        if topTableViewConstraint.constant < 0 {
            topTableViewConstraint.constant = 0
        }
        
        if topTableViewConstraint.constant > maximumOffset {
            topTableViewConstraint.constant = maximumOffset
        }
        
        view.layoutIfNeeded()
        
        previousOffset = scrollView.contentOffset
    }
    
    
}
