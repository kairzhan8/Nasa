//
//  MainViewController.swift
//  Nasa
//
//  Created by kairzhan on 7/26/21.
//

import UIKit
import RxSwift
import Alamofire

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
        navigationItem.title = "NASA photos"
        bindView()
    }
    
    private func bindView() {
        if Connectivity.isConnectedToInternet {
            let output = viewModel.transform(input: .init(loadImages: .just(())))
            
            let res = output.res.publish()
            
            res.element
                .subscribe(onNext: { [unowned self] res in
                    let photos = realm.objects(Photo.self)
                    StorageManager.deletePhotos(photos)
                    StorageManager.savePhotos(res.photos)
                    self.rootView.images = realm.objects(Photo.self)
                    self.rootView.tableView.reloadData()
                }).disposed(by: bag)
            
            res.loading
                .bind(to: ProgressView.instance.rx.loading)
                .disposed(by: bag)
            
            res.errors
                .bind(to: rx.error)
                .disposed(by: bag)
            
            res.connect()
                .disposed(by: bag)
         } else {
            self.rootView.images = realm.objects(Photo.self)
            self.rootView.tableView.reloadData()
        }
        
        rootView.imageTapped = { [unowned self] image in
            let newImageView = ZoomImageView()
            newImageView.setImage(image: image)
            newImageView.frame = self.view.frame
            newImageView.backgroundColor = .black
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
        }
    }
    
    @objc private func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
}
