//
//  HotelListViewController.swift
//  Hotel
//
//  Created by Vadlet on 01.11.2022.
//

import UIKit

final class HotelListViewController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    private lazy var activityIndicator = UIActivityIndicatorView()
    
    private lazy var sortedHotels: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Distance", "Suites availability"])
        segmentedControl.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    private var viewModel: HotelListViewModelProtocol
    
    // MARK: - Initializers
    init(_ viewModel: HotelListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
        setupActivityIndicator()
        fetchHotelsModel()
        setupTableView()
        setupConstraints()
    }
    
    private func fetchHotelsModel() {
        viewModel.fetchHotels { [weak self] error in
            self?.showAlertError(withError: error)
        } successCompletion: { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc
    private func valueChanged(_ segmentedControl: UISegmentedControl) {
        viewModel.filterHotels(at: segmentedControl.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(HotelListTableViewCell.self, forCellReuseIdentifier: HotelListTableViewCell.cellID)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupConstraints() {
        sortedHotels.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        view.addSubview(sortedHotels)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            sortedHotels.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sortedHotels.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .offset),
            sortedHotels.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: .inset),
            
            tableView.topAnchor.constraint(equalTo: sortedHotels.bottomAnchor, constant: .offset),
            tableView.leadingAnchor.constraint(equalTo: sortedHotels.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: sortedHotels.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showAlertError(withError error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Try again", style: .default))
        present(alertController, animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HotelListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfCell()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelListTableViewCell.cellID,
                                                       for: indexPath) as? HotelListTableViewCell else {
            return UITableViewCell() }
        
        cell.viewModel = viewModel.returnCell(at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = HotelDetailViewController()
        vc.viewModel = viewModel.returnDetailViewModel(at: indexPath)
        present(vc, animated: true)
    }
}
