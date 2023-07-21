//
//  ColorListNewPresenter.swift
//  MVPColorList
//
//  Created by Ka4aH on 24.03.2023.
//

import Foundation

final class ColorListNewPresenter: ColorListPresenterProtocol {
    // Определеяем View через слабую ссылку.
    private weak var view: ColorListViewProtocol?
    
    // Определеяем модель, из которой будем брать данные для View
    private var model: ColorListModel = ColorListModel()
    
    // Метод, при вызове которого будет устанавливаться View для Presenter
    func setView(_ view: ColorListViewProtocol) {
        self.view = view
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numbersOfRowSelection(_ section: Int) -> Int {
        return model.colorList.count
    }
    
    func titleForRow(at indexPath: IndexPath) -> String {
        let color = model.colorList[indexPath.row]
        return color.name
    }
    
    func backgroundColorForCell(at indexPath: IndexPath) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let color = model.colorList[indexPath.row]
        let resultColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = (red: color.red, green: color.green, blue: color.blue)
        return resultColor
    }
    
    func didSelectColor(at indexPath: IndexPath) {
        removeColor(at: indexPath.row)
    }
    
    func getTitleForActionButton() -> String {
        return "ADD NEW COLOR"
    }
    
    func actionButtonTapped() {
        addRandomColor()
    }
    
    private func removeColor(at index: Int) {
        model.removeColor(at: index)
        view?.reloadTable()
    }
    
    private func showAlert(for model: ColorInfo) {
    }
    
    private func addRandomColor() {
        let newColor = ColorInfo(name: "Random Color", red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1))
        model.addColor(newColor)
        view?.reloadTable()
    }
}
