//
//  TVListViewController.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import UIKit
import RxSwift

class TVListViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.register(TVShowCellView.self,
                            forCellWithReuseIdentifier: TVShowCellView.identifier)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let viewModel: TVListViewModel
    private let refreshControl = UIRefreshControl()
    private let diposeBag = DisposeBag()
    
    init(with viewModel: TVListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor =  UIColor.background
        addSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel.resetPagination()
        setCollection(with: 0)
    }
    
    private func addSubviews() {
        self.view.addSubview(collectionView)
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30).isActive = true
        collectionView.widthAnchor.constraint(lessThanOrEqualTo: self.view.widthAnchor, multiplier: 1).isActive = true
    }
    
    func setCollection(with page: Int) {
        viewModel.getTvShows(for: page, navigation: self.navigationController)
            .subscribe(onNext: { [weak self] shows in
                guard let self = self else { return }
                self.viewModel.shows.append(contentsOf: shows)
                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }).disposed(by: diposeBag)
    }

    
    @objc
    private func didPullToRefresh(_ sender: Any) {
        viewModel.resetPagination()
        setCollection(with: 0)
    }
}

// MARK: - Collection Datasource
extension TVListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVShowCellView.identifier,
                                                            for: indexPath) as? TVShowCellView else {
            return UICollectionViewCell(frame: .zero)
        }
        cell.tag = indexPath.row
        cell.setupCell(with: viewModel.shows[safe: indexPath.row], tag: indexPath.row)
        return cell
    }
}

// MARK: - Collection Delegate
extension TVListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                 willDisplay cell: UICollectionViewCell,
                   forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.shows.count - 1 {
            viewModel.currentPage += 1
            setCollection(with:  viewModel.currentPage)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.presentShowDetail(with: viewModel.shows[indexPath.row], navigation: self.navigationController)
    }
}

// MARK: - Collection Flow Layout
extension TVListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
