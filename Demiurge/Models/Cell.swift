import Foundation
import UIKit


enum CellType : CaseIterable {
    case dead
    case live
    case life
}


struct Cell {
    let name: String
    let description: String
    let imageName: String
    let gradientColors: [CGColor]
    let type: CellType
    
    static func getBy(type: CellType) -> Cell {
        switch (type) {
        case .dead:
            return Cell(name: "Мертвая", description: "или прикидывается", imageName: "skeleton", gradientColors: [UIColor.blue.cgColor,UIColor.green.cgColor], type: .dead)
        case .live:
            return Cell(name: "Живая", description: "и шевелится!", imageName: "boom", gradientColors: [UIColor.orange.cgColor, UIColor.yellow.cgColor], type: .live)
        case .life:
            return Cell(name: "Жизнь", description: "Ку-ку!", imageName: "chick", gradientColors: [UIColor.purple.cgColor, UIColor.systemPink.cgColor], type: .life)
        }
    }
}
