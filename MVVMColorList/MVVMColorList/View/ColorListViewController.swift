//
//  ViewController.swift
//  MVVMColorList
//
//  Created by Ka4aH on 02.04.2023.
//

import UIKit

final class ColorListViewController: UIViewController {

    private let tableView = UITableView()
    private var viewModel: ColorListViewModelProtocol = ColorListViewModel() // ColorListNewViewModel()
    
    private let cellId = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateView = { [weak self] in
            self?.tableView.reloadData()
        }
        setupTable()
    }

    private func setupTable() {
        self.view.addSubview(tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        self.tableView.frame = view.frame
    }
}

// MARK: - DataSource
extension ColorListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let actionButton = UIButton()
        actionButton.setTitle(viewModel.titleForActionButton, for: .normal)
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return actionButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let cellText = viewModel.titleForRow(indexPath)
        
        if #available(iOS 14.0, *) {
            // For iOS 14.0+
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = cellText
            cell.contentConfiguration = contentConfiguration
        } else {
            // For iOS 3.0 - 14.0
            cell.textLabel?.text = cellText
        }
        
        let colorRGB = viewModel.backgroundColorForCell(indexPath)
        let customColor = UIColor(red: colorRGB.red, green: colorRGB.green, blue: colorRGB.blue, alpha: 1)
        
        cell.contentView.backgroundColor = customColor
        return cell
    }
    
    @objc private func actionButtonTapped() {
        viewModel.actionButtonTapped()
    }
}

// MARK: - Delegate
extension ColorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.cellTapped(indexPath)
    }
}
