//
//  EventTypeViewController.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit
import Parchment

class EventTypeViewController: UIViewController {

    // get instance of VM
    var viewModel: EventTypeViewModel? {
        didSet {
            fillUI()
        }
    }
    var pagingViewController = PagingViewController<PagingIndexItem>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        viewModel = EventTypeViewModelImp()
        viewModel?.getEventType()
        setTabsPager()
    }
    
    func setTabsPager() {
        pagingViewController.dataSource = self
        // Add the paging view controller as a child view controller and
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pagingViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 40)
            ])
    }
    


}
// this part realted to the VM updated listener
extension EventTypeViewController {
    
    func fillUI() {
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.updatedModelEventType.bind {
       //     self.stopAnimating()
            if $0 {
                self.pagingViewController.reloadData()
                self.pagingViewController.reloadMenu()
            } else {
                // to show the error
                if viewModel.errorDescription != "" {
                    print(viewModel.errorDescription ?? "")
                }
            }
        }
    }
}

extension EventTypeViewController : PagingViewControllerDataSource {
    
    func numberOfViewControllers<T>(in pagingViewController: PagingViewController<T>) -> Int where T : PagingItem, T : Comparable, T : Hashable {
        return viewModel?.eventType.count ?? 0
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController where T : PagingItem, T : Comparable, T : Hashable {
        return CityViewController(title: viewModel?.eventType[index].name ?? "")
    }
    
    func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T where T : PagingItem, T : Comparable, T : Hashable {
        return PagingIndexItem(index: index, title: viewModel?.eventType[index].name ?? "") as! T
    }
    
}

