//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by DH on 2018. 3. 3..
//  Copyright © 2018년 dh. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet private weak var button: UIButton!
    
    private lazy var disposeBag = DisposeBag()
    private lazy var viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Input
        
        let timer = Observable<Int>.interval(1, scheduler: MainScheduler.instance)

        timer
            .bind(to: viewModel.input.number)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(onNext: viewModel.didClick)
            .disposed(by: disposeBag)
        
        // Output
        
        viewModel.output.number
            .drive(button.rx.title(for: .normal))
            .disposed(by: disposeBag)
        
        viewModel.output.date
            .subscribe(onNext: { [weak self] in
                guard let `self` = self, let date = $0 else { return }
                self.printer(date)
            }).disposed(by: disposeBag)
    }
    
    func printer(_ text: String) {
        print(">>> Text : \(text)")
    }
}
