//
//  Observable.swift
//  NY Times
//
//  Created by Mohamed Zaki on 10/08/2022.
//

import Foundation

class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }

    init( _ value: T?) {
        self.value = value
    }

    private var listener: ((T?) -> Void)?

    func bind(_ listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
