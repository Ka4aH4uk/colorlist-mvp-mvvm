//
//  ViewController.swift
//  MVPColorList
//
//  Created by Ka4aH on 23.03.2023.
//

import UIKit

final class ColorListViewController: UIViewController {

    private let tableView = UITableView()
    private let presenter: ColorListPresenterProtocol = ColorListPresenter()
    
    private let cellIdentifier = "MyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setView(self)
        setupTable()
    }

    private func setupTable() {
        self.view.addSubview(tableView)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.frame = view.frame
    }
}

extension ColorListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numbersOfRowSelection(section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let actionButton = UIButton()
        actionButton.setTitle(presenter.getTitleForActionButton(), for: .normal)
        actionButton.setTitleColor(.black, for: .normal)
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return actionButton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let cellText = presenter.titleForRow(at: indexPath)
        
        if #available(iOS 14.0, *) {
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = cellText
            cell.contentConfiguration = contentConfiguration
        } else {
            cell.textLabel?.text = cellText
        }
        
        let colorRGB = presenter.backgroundColorForCell(at: indexPath)
        let customColor = UIColor(red: colorRGB.red, green: colorRGB.green, blue: colorRGB.blue, alpha: 1)
        
        cell.contentView.backgroundColor = customColor
        return cell
    }
    
    @objc private func actionButtonTapped() {
        presenter.actionButtonTapped()
    }
}

extension ColorListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectColor(at: indexPath)
    }
}

extension ColorListViewController: ColorListViewProtocol {
    func reloadTable() {
        tableView.reloadData()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
