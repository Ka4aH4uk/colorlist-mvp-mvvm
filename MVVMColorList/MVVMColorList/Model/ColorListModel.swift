import Foundation

// Структура, которая хранит данные
struct ColorListModel {
    // Переменная, по которой можно получить список цветов из модели. Она возвращает массив элементов ColorInfo
    var colorList: [ColorInfo] {
        return privateColorList
    }
    
    // Приватная переменная со списком цветов, в которую будут вноситься изменения только внутри самой модели
    private var privateColorList: [ColorInfo] = []
    
    init() {
        setupDefaultColor()
    }
    
    // Приватный метод, который устанавливает начальные значения для переменной privateColorList
    private mutating func setupDefaultColor() {
        let modelRed = ColorInfo(name: "Custom Red", red: 1, green: 0, blue: 0)
        let modelGreen = ColorInfo(name: "Custom Green", red: 0, green: 1, blue: 0)
        let modelBlue = ColorInfo(name: "Custom Blue", red: 0, green: 0, blue: 1)
        let modelYellow = ColorInfo(name: "Custom Yellow", red: 1, green: 1, blue: 0)
        
        privateColorList = ([modelRed, modelGreen, modelBlue, modelYellow])
    }
    
    // Метод позволяет добавить новый элемент в список privateColorList
    mutating func addColor(_ color: ColorInfo) {
        self.privateColorList.append(color)
    }
    
    // Метод для удаления элемента по индексу
    mutating func removeColor(at index: Int) {
        self.privateColorList.remove(at: index)
    }
    
    mutating func shuffleItems() {
        self.privateColorList.shuffle()
    }
}

struct ColorInfo {
    var name: String
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
}
