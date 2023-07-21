//
//  ColorListPresenter.swift
//  MVPColorList
//
//  Created by Ka4aH on 23.03.2023.
//

import Foundation

protocol ColorListViewProtocol: AnyObject {
    // Метод, с помощью которого подается сигнал для View о необходимости обновлении таблицы
    func reloadTable()
    
    // Будет оповещать View о необходимости показать Alert с данными
    func showAlert(title: String, message: String)
}

protocol ColorListPresenterProtocol: AnyObject {
    
    // Устанавливаем View для Presenter
    func setView(_ view: ColorListViewProtocol)
    
    // Возвращает количество секций в таблице
    func numberOfSections() -> Int
    
    // Возвращает количество строк в определенной секции
    func numbersOfRowSelection(_ section: Int) -> Int
    
    // Возвращает текст для определенной ячейки
    func titleForRow(at indexPath: IndexPath) -> String
    
    // Возвращает параметры для установки цвета ячейки
    func backgroundColorForCell(at indexPath: IndexPath) -> (red: CGFloat, green: CGFloat, blue: CGFloat)
    
    // Метод вызывается при нажатии на ячейку
    func didSelectColor(at indexPath: IndexPath)
    
    // Метод возвращает название для кнопки действия
    func getTitleForActionButton() -> String
    
    // Метод вызывается при нажатии на нопку действия
    func actionButtonTapped()
}

final class ColorListPresenter: ColorListPresenterProtocol {
    
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
        let color = model.colorList[indexPath.row]
        showAlert(for: color)
    }
    
    func getTitleForActionButton() -> String {
        return "ADD NEW COLOR"
    }
    
    func actionButtonTapped() {
        addRandomColor()
    }
    
    private func showAlert(for model: ColorInfo) {
        let alertTitle: String = model.name
        let alertMessage: String = "Red: \(model.red), Green: \(model.green), Blue: \(model.blue)"
        view?.showAlert(title: alertTitle, message: alertMessage)
    }
    
    private func addRandomColor() {
        let newColor = ColorInfo(name: "Random Color", red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1))
        model.addColor(newColor)
        view?.reloadTable()
    }
}
