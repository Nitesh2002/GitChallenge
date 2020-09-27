//
//  HomeViewController.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    private let cellResuseIdentifier = "cell"
    private var viewModel: InfoListControllerVM!
    private var loaderView = LoaderView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellResuseIdentifier)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: cellResuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupViewModel()
        setupUI()
        setupBinding()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func setupViewModel() {
        viewModel = InfoListControllerVM(infoServiceRequest: InfoServiceRequests())
    }
    
    private func setupUI() {
        setupAutoLayout()
    }
    
    
    private func setupBinding() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.title = self?.viewModel.getTitle()
                self?.tableView.reloadData()
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
    }
    private func setupAutoLayout() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}


// MARK: UITableViewDataSource & UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellResuseIdentifier, for: indexPath) as? InfoTableViewCell
        if let cellViewModel = viewModel.getCellViewModel(for: indexPath) {
            cell?.renderCell(with: cellViewModel)
        }
        return cell ?? UITableViewCell()
    }
}
