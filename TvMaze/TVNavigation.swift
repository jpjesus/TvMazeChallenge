//
//  TVNavigation.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import Moya

final class TVNavigation {
    
    let provider = MoyaProvider<TVMazeProvider>()
    var navigationController: UINavigationController?
    
    init(with window: UIWindow) {
        let viewModel = TVListViewModel(with: provider)
        let vc = TVListViewController(with: viewModel)
        navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
