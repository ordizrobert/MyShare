//
//  data.swift
//  MyShare
//
//  Created by robert ordiz on 4/20/23.
//

class EachShareData {
    var name: String?
    var totalShare: Double?
    var items: [Items]?
    
    init(name: String? = nil, total: Double? = nil, items: [Items]? = []) {
        self.name = name
        self.totalShare = total
        self.items = items
    }
}

class Items {
    var price: Double?
    var item: String?
    
    init(price: Double? = nil, item: String? = nil) {
        self.item = item
        self.price = price
    }
}
