//
//  InfoViewController.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    // Progammer defined variables
    private let cellResuseIdentifier = "cell"
    private var viewModel: InfoListControllerVM!
    private var loaderView = LoaderView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellResuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: cellResuseIdentifier)
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                     #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    // MARK: ViewLifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        bind()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewWillAppear()
    }
    
    // MARK: Controller and ViewModel binding
    
    private func bind() {
        setupViewModel()
        setupUI()
        setupBinding()
    }
    
    private func setupViewModel() {
        viewModel = InfoListControllerVM(infoServiceRequest: InfoServiceRequests())
    }
    
    private func setupUI() {
        setupTableViewUI()
    }
    
    private func setupTableViewUI() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.addSubview(self.refreshControl)
    }
    
    private func setupBinding() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.title = self?.viewModel.getTitle()
                self?.tableView.reloadData()
                if (self?.refreshControl.isRefreshing)!{
                    self?.refreshControl.endRefreshing()
                }
            }
        }
        
        viewModel.showLoader = { [weak self] (shouldShowLoader, message) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.loaderView.loaderDescription = message ?? ""
                if shouldShowLoader {
                    self.loaderView.showLoaderOn(view: self.view)
                } else {
                    self.loaderView.hideLoader()
                }
            }
        }
        viewModel.showAlert = { [weak self] message in
            DispatchQueue.main.async {
                self?.showBasicAlert(message: message)
            }
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModel.pullToRefresh()
    }
}


// MARK: UITableViewDataSource & UITableViewDelegate

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellResuseIdentifier, for: indexPath) as? InfoTableViewCell
        if let cellViewModel = viewModel.getCellViewModel(for: indexPath) {
            cell?.renderCell(with: cellViewModel)
        }
        return cell ?? UITableViewCell()
    }
}

extension UIViewController {
    func showBasicAlert(message: String, completion: (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
            completion?()
        }
        alertViewController.addAction(okAction)
        alertViewController.message = message
        present(alertViewController, animated: true, completion: nil)
    }
}
