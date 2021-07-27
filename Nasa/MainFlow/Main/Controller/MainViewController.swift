//
//  MainViewController.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit
import RxSwift

final class MainViewController: UIViewController, ViewHolder, MainModule {
    typealias RootViewType = MainView
    
    private let bag = DisposeBag()
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(loadImages: .just(())))
        
        let res = output.res.publish()
        
        res.element
            .subscribe(onNext: { [unowned self] res in
                
            }).disposed(by: bag)
        
        res.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: bag)
        
        res.errors
            .bind(to: rx.error)
            .disposed(by: bag)
        
        res.connect()
            .disposed(by: bag)
    }
}
