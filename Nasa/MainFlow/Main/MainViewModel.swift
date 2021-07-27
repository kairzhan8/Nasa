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
    private let apiKey = "PlELEHjtJJ1LxADmw8ce6Bqmrub6HXVo8c4Ay8Qv"
    struct Input {
        let loadImages: Observable<Void>
    }
    
    struct Output {
        let res: Observable<LoadingSequence<PhotosResponse>>
    }
    
    private let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let res = input.loadImages
            .flatMap { [unowned self] in
                return self.apiService.makeRequest(to: MainTarget.getPhotos(sol: sol, page: page, api_key: apiKey))
                    .result(PhotosResponse.self)
                    .asLoadingSequence()
            }.share()
        return .init(res: res)
    }
}
