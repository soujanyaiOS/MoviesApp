//
//  Dynamic.swift
//  Movies
//
//  Created by soujanya Balusu on 24/05/22.
//  
//

import Foundation

class Dynamic<T>: NSObject {
    typealias Listener = (T) -> Void
    var listener: Listener?

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        value = v
    }
}
