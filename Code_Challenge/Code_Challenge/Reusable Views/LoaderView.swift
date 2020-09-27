//
//  LoaderView.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    private lazy var shadowView: UIView = {
        let shadowView = UIView()
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()

    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var loader: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.color = .green
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    private lazy var loaderDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var loaderDescription: String = "" {
        didSet {
            loaderDescriptionLabel.text = loaderDescription
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        setupShadowView()
        setupContainerStackView()
        setupLoader()
        setupLoaderDescriptionLabel()
    }

    private func setupShadowView() {
        addSubview(shadowView)
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupContainerStackView() {
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }

    private func setupLoader() {
        containerStackView.addArrangedSubview(loader)
    }

    private func setupLoaderDescriptionLabel() {
        containerStackView.addArrangedSubview(loaderDescriptionLabel)
    }

    func showLoaderOn(view: UIView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        view.addSubview(self)
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        loader.startAnimating()
    }

    func hideLoader() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        loader.stopAnimating()
        self.removeFromSuperview()
    }

}
