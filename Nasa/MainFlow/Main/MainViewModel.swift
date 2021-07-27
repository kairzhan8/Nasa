//
//  MainViewModel.swift
//  Nasa
//
//  Created by kairzhan on 7/27/21.
//

import RxSwift

class MainViewModel: ViewModel {
    private let sol = "1000"
    private let page = "1"
    private let apiKey = ""
    struct Input {
        let loadImages: Observable<Void>
    }
    
    struct Output {
        let res: Observable<LoadingSequence<String>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let res = input.loadImages
            .flatMap { [unowned self] in
                return self.apiService.makeRequest(to: MainTarget.getPhotos(sol: sol, page: page, api_key: apiKey))
                    .result(String.self)
                    .asLoadingSequence()
            }.share()
        return .init(res: res)
    }
}
