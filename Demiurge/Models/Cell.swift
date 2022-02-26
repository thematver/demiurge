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
    let type: CellType
    
    static func getBy(type: CellType) -> Cell {
        switch (type) {
        case .dead:
            return Cell(name: "Мертвая", description: "или прикидывается", imageName: "skeleton", type: .dead)
        case .live:
            return Cell(name: "Живая", description: "и шевелится!", imageName: "boom", type: .live)
        case .life:
            return Cell(name: "Жизнь", description: "Ку-ку!", imageName: "chick", type: .life)
        }
    }
}
