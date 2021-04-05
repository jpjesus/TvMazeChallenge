//
//  TVListViewModel.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import UIKit

final class TVListViewModel {
    
    private let provider: MoyaProvider<TVMazeProvider>
    var currentPage: Int = 0
    var shows: [Show] = []
    
    init(with provider: MoyaProvider<TVMazeProvider>) {
        self.provider = provider
    }
    
    func getTvShows(for page: Int,
                    navigation: UINavigationController?) -> Observable<[Show]> {
        return provider.rx.request(.getTvShows(page: currentPage))
            .do(onError: { error in
                print(error.localizedDescription)
                UIViewController.showOfflineAlert(with: navigation)
            })
            .asObservable()
            .map([Show].self)
            .retry(2)
    }
    
    func resetPagination() {
        shows = []
        currentPage = 0
    }
    
    func presentShowDetail(with show: Show, navigation: UINavigationController?) {
        let viewModel = ShowDetailViewModel(with: show)
        let vc = ShowDetailViewController(with: viewModel)
        vc.modalPresentationStyle = .formSheet
        navigation?.present(vc, animated: true)
    }
}
