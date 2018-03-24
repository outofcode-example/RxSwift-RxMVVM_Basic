//
//  ViewModel.swift
//  RxSwiftTest
//
//  Created by DH on 2018. 3. 23..
//  Copyright © 2018년 dh. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

struct MainViewModel {
    
    let input: Input
    let output: Output
    
    init() {
        input = Input()
        output = Output(
            number: input.number.asDriver()
                .filter { $0 >= 0 }.map { String($0) },
            date: input.number.asObservable()
                .map { _ in Date().description }
        )
    }
}

extension MainViewModel {
    
    func didClick() {
        print(">>> on Click")
    }
}

extension MainViewModel {
    struct Input {
        let number = Variable<Int>(-1)
    }
    
    struct Output {
        let number: Driver<String>
        let date: Observable<String?>
    }
}
