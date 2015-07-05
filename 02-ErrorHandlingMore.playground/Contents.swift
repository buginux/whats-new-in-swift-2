//: Playground - noun: a place where people can play

import UIKit

enum BookShelfError: ErrorType {
    case NoEnoughSpace(required: Int)
    case OutOfBooks
    case ShopNotFound
}

let shopList = ["新华书店": 5000]

class BookShelf: CustomStringConvertible {
    private let maximumBooks = 1000
    private(set) var books: Int = 0
    
    var description: String {
        return "书柜当前还有\(books)本书"
    }
    
    func purchaseBooks(count: Int) throws {
        guard books + count <= maximumBooks else {
            let required = (books + count) - maximumBooks
            throw BookShelfError.NoEnoughSpace(required: required)
        }
        
        books += count
    }
    
    func lendBooks(count: Int) throws {
        guard count <= books else {
            throw BookShelfError.OutOfBooks
        }
        
        books -= count
    }
}

func beginReceipt() {
    print("又要开始大采买了，真是买书如山倒啊")
}

func endReceipt() {
    print("购物结束，该去剁手去了")
}

func starterShelf() -> BookShelf {
    let myShelf = BookShelf()
    try! myShelf.purchaseBooks(100)
    return myShelf
}

let shelf = starterShelf()

do {
    
    beginReceipt()
    defer {
        endReceipt()
    }
    
    guard let buyCount = shopList["布莱克书店"] else {
        throw BookShelfError.ShopNotFound
    }
    
    try shelf.purchaseBooks(buyCount)
    
} catch BookShelfError.NoEnoughSpace(let required) {
    print("书柜满啦，新买的书放不下咯。还差\(required)个空位，赶紧买个新书柜吧")
} catch BookShelfError.ShopNotFound {
    print("这家书店可不在你的购物计划表内哦，再核对一下吧")
}

shelf

