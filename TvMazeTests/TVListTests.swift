//
//  TVListTests.swift
//  TvMazeTests
//
//  Created by Jesus Parada on 5/04/21.
//

import Foundation
import XCTest
import RxSwift
import Moya
import RxCocoa
@testable import TvMaze

class TVListTests: XCTestCase {
    
    private let disposeBag = DisposeBag()
    private var viewModel: TVListViewModel?
    
    override func setUp() {
        super.setUp()
        // Given
        viewModel = TVListViewModel(with: MoyaProvider<TVMazeProvider>(stubClosure: MoyaProvider<TVMazeProvider>.immediatelyStub))
    }
    
    func test_getTVshows_ShouldBeEqualTo() {
        // Given
        var shows: [Show] = []
        let expectedCount: Int = 2
        let expectation =  self.expectation(description: "fetching tvshows")
        let expectedID = 250
        let expectedImageUrl = "https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg"
        let expectedName = "Kirby Buckets"
        let expectedRating = 0.0
        
        // When
        viewModel?.getTvShows(for: 0, navigation: UINavigationController(rootViewController: UIViewController()))
            .asObservable()
            .subscribe(onNext: { list in
                shows = list
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        // Then
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(shows.count, expectedCount, "the amount of shows should be equal to \(expectedCount)")
        
        guard let show = shows.first else {
            XCTFail("the first show shouldnt be nil")
            return
        }
        
        XCTAssertEqual(show.name, expectedName, "the show name should be equal to \(expectedName)")
        XCTAssertEqual(show.image, expectedImageUrl, "the show image url should be equal to \(expectedImageUrl)")
        XCTAssertEqual(show.id, expectedID, "the show id should be equal to \(expectedImageUrl)")
        XCTAssertEqual(show.rating, expectedRating, "the show rating should be equal to \(expectedRating)")
    }
}
