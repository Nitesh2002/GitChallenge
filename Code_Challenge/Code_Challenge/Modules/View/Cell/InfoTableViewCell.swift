//
//  InfoTableViewCell.swift
//  Code_Challenge
//
//  Created by Nitesh on 27/09/20.
//  Copyright © 2020 Nitesh. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    lazy private var infoImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "placeholder_photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-SemiBold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var viewModel: InfoTableCellVMRepresentable!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func renderCell(with viewModel: InfoTableCellVMRepresentable) {
        setupUI()
        self.viewModel = viewModel
        renderData()
    }
    
    private func setupUI() {
        selectionStyle = .none
        let marginGuide = contentView.layoutMarginsGuide
        setupImageView(marginGuide: marginGuide)
        // configure titleLabel
        setupNameLabel(marginGuide: marginGuide)
        // configure descriptionLabel
        setupDescriptionLabel(marginGuide: marginGuide)
    }
    
    private func setupImageView(marginGuide:UILayoutGuide){
        contentView.addSubview(infoImageView)
        
        NSLayoutConstraint.activate([
            infoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            infoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            infoImageView.widthAnchor.constraint(equalToConstant: 40),
            infoImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    private func setupNameLabel(marginGuide:UILayoutGuide){
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: infoImageView.leftAnchor, constant: 60),
            nameLabel.topAnchor.constraint(equalTo: infoImageView.topAnchor)
            
        ])
    }
    
    private func setupDescriptionLabel(marginGuide:UILayoutGuide){
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
    }
    
    private func renderData() {
        nameLabel.text = viewModel.cellSetupModel.title.count == 0 ? "No Title" : viewModel.cellSetupModel.title
        infoImageView.loadImageUsingUrlString(urlString: viewModel.cellSetupModel.imageURL)
        descriptionLabel.text = viewModel.cellSetupModel.description.count == 0 ? "No Description" : viewModel.cellSetupModel.description
    }
    
}
