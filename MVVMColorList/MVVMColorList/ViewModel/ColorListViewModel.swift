//
//  ColorListViewModel.swift
//  MVVMColorList
//
//  Created by Ka4aH on 02.04.2023.
//

import Foundation

protocol ColorListViewModelProtocol {
    // Возвращает количество секций в таблице
    var numberOfSections: Int { get }
    
    // Возвращает количество строк в определенной секции
    var numberOfRowInSection: (_ section: Int) -> Int { get }
    
    // Возвращает текст для кнопки с действием
    var titleForActionButton: String { get }
    
    // Возвращает текст для определенной ячейки
    var titleForRow: ((_ index: IndexPath) -> String) { get }
    
    // Возвращает параметры для установки цвета ячейки
    var backgroundColorForCell: (_ index: IndexPath) -> (red: CGFloat, green: CGFloat, blue: CGFloat) { get }
    
    // Возвращает количество секций в таблице
    var updateView: (() -> Void)? { get set }
    
    // Метод вызывается при нажатии на кнопку действия
    func actionButtonTapped()
    
    //Метод вызывается при нажатии на ячейку
    func cellTapped(_ index: IndexPath)
}

final class ColorListViewModel: ColorListViewModelProtocol {
    
    var numberOfSections: Int {
        return 1
    }
    
    private var model: ColorListModel = ColorListModel()
    lazy var numberOfRowInSection: (Int) -> Int = getNumberOfRowsInSection
    private func getNumberOfRowsInSection(_ section: Int) -> Int {
        return model.colorList.count
    }
    
    var titleForActionButton: String {
        return "ADD NEW COLOR"
    }
    
    var updateView: (() -> Void)?
    
    lazy var titleForRow: ((IndexPath) -> String) = getTitleForRow
    private func getTitleForRow(at indexPath: IndexPath) -> String {
        let color = model.colorList[indexPath.row]
        return color.name
    }
    
    lazy var backgroundColorForCell: (IndexPath) -> (red: CGFloat, green: CGFloat, blue: CGFloat) = getBackgroundColorForCell
    private func getBackgroundColorForCell(at indexPath: IndexPath) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let color = model.colorList[indexPath.row]
        let resultColor: (red: CGFloat, green: CGFloat, blue: CGFloat) = (red: color.red, green: color.green, blue: color.blue)
        return resultColor
    }
    
    func actionButtonTapped() {
        addNewRandomColor()
    }
    private func addNewRandomColor() {
        let newColor = ColorInfo(name: "Random Color", red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1))
        model.addColor(newColor)
        updateView?()
    }
    
    func cellTapped(_ indexPath: IndexPath) {
        removeColor(at: indexPath.row)
    }
    private func removeColor(at index: Int) {
        model.removeColor(at: index)
        updateView?()
    }
}
