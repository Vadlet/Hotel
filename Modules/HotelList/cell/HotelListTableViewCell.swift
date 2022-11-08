//
//  HotelListTableViewCell.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

final class HotelListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let cellID = "HotelListTableViewCell"
    
    private lazy var containerView = UIView(cornerRadius: .smallRadius)
    private lazy var nameLabel = UILabel(font: .avenirMedium16())
    private lazy var addressLabel = UILabel(font: .avenir14())
    private lazy var starsLabel = UILabel(font: .avenir14())
    private lazy var distanceLabel = UILabel(font: .avenir14())
    private lazy var suitesAvailability = UILabel(font: .avenir14())
    
    var viewModel: HotelListCellViewModelProtocol? {
        didSet {
            setupUI()
        }
    }
    
    // MARK: - Methods
    private func setupUI() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address
        starsLabel.text = viewModel.stars
        distanceLabel.text = viewModel.distance
        suitesAvailability.text = viewModel.suitesAvailability
        
        setupTableViewCell()
        setupConstraints()
    }
    
    private func setupTableViewCell() {
        selectionStyle = .none
        backgroundColor = .white
    }
    
    private func setupConstraints() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel,
                                                       addressLabel,
                                                       starsLabel,
                                                       distanceLabel,
                                                       suitesAvailability
                                                      ],
                                    axis: .vertical,
                                    spacing: .smallOffSet)
        
        addSubview(containerView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: .offset),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .offset),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .inset),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .inset),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: .stackOffset),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .stackOffset),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .stackInset),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: .stackInset)
        ])
    }
}
