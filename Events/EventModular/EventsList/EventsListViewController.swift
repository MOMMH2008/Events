//
//  EventsListViewController.swift
//  Events
//
//  Created by Mohamed Helmy on 7/16/19.
//  Copyright © 2019 MohamedHelmy. All rights reserved.
//

import UIKit

class EventsListViewController: UIViewController {

    var eventsTable: UITableView = UITableView()
    var refreshControl = UIRefreshControl()
    var eventType = ""
    // get instance of VM
    var viewModel: EventsListViewModel? {
        didSet {
            fillUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventsTable.dataSource = self
        eventsTable.delegate = self
        eventsTable.tableFooterView = UIView()
        eventsTable.frame = CGRect(x: 8, y: 8, width: self.view.frame.width - 16, height:  self.view.frame.height - 120)
        eventsTable.register(EventCellTableViewCell.self, forCellReuseIdentifier: "EventCellTableViewCell")
        eventsTable.register(UINib(nibName: "EventCellTableViewCell", bundle: nil), forCellReuseIdentifier: "EventCellTableViewCell")
        self.view.addSubview(eventsTable)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        eventsTable.addSubview(refreshControl)
        
        
        viewModel = EventsListViewModelImp()
        viewModel?.getEvents(eventType: eventType, page: "1")
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshTable(refreshControl: UIRefreshControl) {
        viewModel?.getEvents(eventType: eventType, page: "1")
        
    }
    
}

extension EventsListViewController {
    
    func fillUI() {
        
        if !isViewLoaded {
            return
        }
        
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.updatedModelEvent.bind {
            self.refreshControl.endRefreshing()
            //     self.stopAnimating()
            if $0 {
                self.eventsTable.reloadData()
            } else {
                // to show the error
                if viewModel.errorDescription != "" {
                    print(viewModel.errorDescription ?? "")
                }
            }
        }
    }
}

extension EventsListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.events.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCellTableViewCell", for: indexPath) as? EventCellTableViewCell {
            if let event = viewModel?.events[indexPath.row] {
                cell.setcell(event: event)
            }
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

}
