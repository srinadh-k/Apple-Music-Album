//
//  MusicAlbumsVC.swift
//  Apple Music Album
//
//  Created by Srinadh on 5/2/20.
//  Copyright © 2020 Srinadh. All rights reserved.
//

import UIKit

class MusicAlbumsVC: UIViewController {
    private var safeArea = UILayoutGuide()
    private let tableView = UITableView()
    private let spinner = UIActivityIndicatorView(style: .large)
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(MusicAlbumsVC.pulledRefreshControl(_:)),
                                 for: .valueChanged)
        refreshControl.tintColor = .gray
        
        return refreshControl
    }()

    let dataSource = MusicAlbumDataSource()
    lazy var viewModel : MusicAlbumViewModel = {
        let viewModel = MusicAlbumViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func loadView() {
      super.loadView()
      safeArea = view.layoutMarginsGuide
      setupTableView()
      setupSpinner()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        self.navigationItem.title = Constants.ConstantValues.kTopAlbums

        
        appicationHandlers()
        
        spinner.startAnimating()
        viewModel.loadTopMusicAlumbs()
    }
    private func setupSpinner(){
        view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    private func setupTableView() {
      tableView.separatorStyle = .none
      view.addSubview(tableView)
      tableView.addSubview(self.refreshControl)

      tableView.translatesAutoresizingMaskIntoConstraints = false
      tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
      tableView.delegate = dataSource
      tableView.dataSource = dataSource
      tableView.register(AlbumTableViewCell.classForCoder(), forCellReuseIdentifier: Constants.Identifiers.kAlubmCell)

    }
    @objc private func pulledRefreshControl(_ refreshControl: UIRefreshControl) {
        refreshControl.beginRefreshing()
        viewModel.loadTopMusicAlumbs()
    }
    private func appicationHandlers(){
        self.dataSource.albumList.addAndNotify(observer: self) { [weak self] _ in
            guard let self = self else { return }
            if !self.dataSource.albumList.value.isEmpty{
                self.tableView.separatorStyle = .singleLine
            }
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            self.refreshControl.endRefreshing()
        }
        
        self.dataSource.redirectToAlubmDetailPage = { [unowned self] album in
            let albumDetails = AlbumDetailsVC()
                albumDetails.albumData = album
                self.navigationController?.pushViewController(albumDetails, animated: true)
        }
        
        self.viewModel.onErrorHandling = { [weak self ]error in
            guard let self = self else {return }
            self.spinner.stopAnimating()
            self.showAlert(message: error.description, onOkAction: {
                if self.refreshControl.isRefreshing{
                    self.refreshControl.endRefreshing()
                }
            })
        }
    }
}
