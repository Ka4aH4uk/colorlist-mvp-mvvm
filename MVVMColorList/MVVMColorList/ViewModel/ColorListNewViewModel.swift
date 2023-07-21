//
//  ColorListNewViewModel.swift
//  MVVMColorList
//
//  Created by Ka4aH on 02.04.2023.
//

import Foundation

final class ColorListNewViewModel: ColorListViewModelProtocol {
    var numberOfSections: Int {
        return 1
    }
    
    private var model: ColorListModel = ColorListModel()
    lazy var numberOfRowInSection: (Int) -> Int = getNumberOfRowsInSection
    private func getNumberOfRowsInSection(_ section: Int) -> Int {
        return model.colorList.count
    }
    
    var titleForActionButton: String {
        return "SHUFFLE COLORS"
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
        shuffleItems()
    }
    private func shuffleItems() {
        model.shuffleItems()
        updateView?()
    }
    
    func cellTapped(_ indexPath: IndexPath) {
        copyAndAddColor(by: indexPath.row)
    }
    private func copyAndAddColor(by index: Int) {
        let color = model.colorList[index]
        model.addColor(color)
        updateView?()
    }
}
