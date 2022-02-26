import Foundation

class Game {
    
    var storage = [Cell]() 
    
    func addCell() {
        if Int.random(in: 0..<2) == 0 {
            addDeadCell()
        } else {
            addLiveCell()
        }
    }
    
    private func addDeadCell() {
        storage.insert(Cell.getBy(type: .dead), at: 0)
        if storage.count >= 3 && storage[0..<3].allSatisfy({ $0.type == .dead }) {
            storage.removeSubrange(0..<3)
            if storage.first?.type == .life {
                storage.removeFirst()
            }
        }
    }
    
    private func addLiveCell() {
        storage.insert(Cell.getBy(type: .live), at: 0)
        if storage.count >= 2 && storage[0..<2].allSatisfy({ $0.type == .live }) {
            storage.removeSubrange(0..<2)
            storage.insert(Cell.getBy(type: .life), at: 0)
        }
    }
    
     private func printInfo() {
         for c in storage {
             print(c.type, terminator: " ")
         }
         print("")
     }

}
