//: Playground - noun: a place where people can play

import UIKit

enum BookShelfError: ErrorType {
    case NoEnoughSpace(required: Int)
    case OutOfBooks
}

class BookShelf: CustomStringConvertible {
    private let maximumBooks = 1000
    private(set) var books: Int = 0
    
    var description: String {
        return "书柜当前还有\(books)本书"
    }
    
    func purchaseBooks(count: Int) throws {
        if books + count > maximumBooks {
            let required = (books + count) - maximumBooks
            throw BookShelfError.NoEnoughSpace(required: required)
        }
        
        books += count
    }
    
    func lendBooks(count: Int) throws {
        if count > books {
            throw BookShelfError.OutOfBooks
        }
        
        books -= count
    }
}

func starterShelf() -> BookShelf {
    let myShelf = BookShelf()
    try! myShelf.purchaseBooks(100)
    return myShelf
}

let shelf = starterShelf()

do {
    try shelf.purchaseBooks(1500)
} catch BookShelfError.NoEnoughSpace(let required) {
    print("书柜满啦，新买的书放不下咯。还差\(required)个空位，赶紧买个新书柜吧")
}

shelf

do {
    // should be OK
    try shelf.lendBooks(50)
    // this one will throw an error
    try shelf.lendBooks(200)
} catch BookShelfError.OutOfBooks {
    print("书都没啦，你还借给谁啊")
}

shelf

