//
//  TvListIntegrationTests.swift
//  TvMazeTests
//
//  Created by Jesus Parada on 5/04/21.
//

import Foundation
import Moya
import XCTest
@testable import TvMaze

class TvListIntegrationTests: XCTestCase {
    
    private var sut: TVListViewController?
    private let navigation = UINavigationController()
    
    override func setUp() {
        super.setUp()
        let viewModel = TVListViewModel(with: MoyaProvider<TVMazeProvider>(stubClosure: MoyaProvider<TVMazeProvider>.immediatelyStub))
        sut = TVListViewController(with: viewModel)
    }
    
    func test_ShowViewControllerViewModel_expectEqualto() {
        let expectedCount = 2
        guard let vc = sut else {
            XCTFail("view controller shouldnt be nil")
            return
        }
        vc.viewWillAppear(true)
        vc.viewDidLoad()
        
        guard let vm: TVListViewModel = Mirror(reflecting: vc)
            .descendant("viewModel") as? TVListViewModel else {
                return
        }
        XCTAssertEqual(vm.shows.count, expectedCount, "the amount of taxis should be equal to \(expectedCount)")
    }
}
