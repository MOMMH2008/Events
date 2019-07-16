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
    var pageIndex = 1
    var fetchingMore = false
    let cellSize = 180
    var appendedEventsList = [ModelEvent]()
    // get instance of VM
    var viewModel: EventsListViewModel? {
        didSet {
            fillUI()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEventTable()
        viewModel = EventsListViewModelImp()
        viewModel?.getEvents(eventType: eventType, page: "\(pageIndex)")
    }
    
    func setupEventTable(){
        eventsTable.dataSource = self
        eventsTable.delegate = self
        eventsTable.tableFooterView = UIView()
        eventsTable.frame = CGRect(x: 8, y: 8, width: self.view.frame.width - 16, height:  self.view.frame.height - 120)
        eventsTable.register(EventCellTableViewCell.self, forCellReuseIdentifier: "EventCellTableViewCell")
        eventsTable.register(UINib(nibName: "EventCellTableViewCell", bundle: nil), forCellReuseIdentifier: "EventCellTableViewCell")
        eventsTable.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        self.view.addSubview(eventsTable)
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        eventsTable.addSubview(refreshControl)
    }
    
    @objc func refreshTable(refreshControl: UIRefreshControl) {
        viewModel?.getEvents(eventType: eventType, page: "\(pageIndex)")
        
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
                if self.pageIndex == 1 {
                    self.appendedEventsList = viewModel.events
                } else {
                    self.fetchingMore = false
                    self.appendedEventsList.append(contentsOf: viewModel.events)
                }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return appendedEventsList.count
        } else if section == 1 && fetchingMore && (pageIndex < 3) {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "EventCellTableViewCell", for: indexPath) as? EventCellTableViewCell {
                let event = appendedEventsList[indexPath.row]
                cell.setcell(event: event)
                cell.selectionStyle = .none
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as? LoadingCell {
                cell.spinner.startAnimating()
                return cell
            } else {
                return UITableViewCell()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "EventDetailsViewController")
            as? EventDetailsViewController else {
                return
        }
        vc.eventDetails = appendedEventsList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(cellSize)
        } else {
            return 50
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = cellSize * appendedEventsList.count
        
        if (offsetY > CGFloat(contentHeight) - scrollView.frame.height * CGFloat(pageIndex)) && (offsetY > 0) && (pageIndex < 3){
            if !fetchingMore {
                beginBatchFetch()
            }
            
        }
    }
    
    func beginBatchFetch() {
        if pageIndex < 3 {
            pageIndex += 1
            fetchingMore = true
            eventsTable.reloadSections(IndexSet(integer: 1), with: .none)
            viewModel?.getEvents(eventType: eventType, page: "\(pageIndex)")
        }
        
    }
    
}
