//
//  TVShowCellView.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import UIKit

class TVShowCellView: UICollectionViewCell {
    
    lazy var cellContainerView: UIView = {
        let view = UIView()
        view.setupRoundedCorners(radius: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.background
        return view
    }()
    
    lazy var showLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.primary
        return label
    }()
    
    lazy var showImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.setupRoundedCorners(radius: 16)
        return image
    }()
    
    private var show: Show?
    static var identifier = "TVShowCellView"
    
    override func prepareForReuse() {
        showLabel.text = ""
        showImage.image = nil
        super.prepareForReuse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.background
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        setConstraints()
    }
    
    func setupCell(with show: Show?, tag: Int) {
        showLabel.text = show?.name
        if self.tag == tag,
           let image = show?.image {
            showImage.loadImage(withUrl: image)
        }
        self.setupBorder(width: 1.5, color: UIColor.primary)
        self.setupRoundedCorners(radius: 15)
    }
    
    private func addSubviews() {
        self.addSubview(cellContainerView)
        self.addSubview(showLabel)
        self.addSubview(showImage)
    }
    
    private func setConstraints() {
        setContainerConstraints()
        setShowImageConstraints()
        setTitleConstraints()
    }
}

private extension TVShowCellView {
    
    func setContainerConstraints() {
        cellContainerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        cellContainerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        cellContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cellContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        cellContainerView.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1).isActive = true
        cellContainerView.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 1).isActive = true
    }
    
    func setShowImageConstraints() {
        showImage.topAnchor.constraint(equalTo: cellContainerView.topAnchor, constant: 8).isActive = true
        showImage.leadingAnchor.constraint(equalTo: cellContainerView.leadingAnchor, constant: 8).isActive = true
        showImage.trailingAnchor.constraint(equalTo: cellContainerView.trailingAnchor, constant: -8).isActive = true
        showImage.heightAnchor.constraint(lessThanOrEqualTo: cellContainerView.heightAnchor, multiplier: 1).isActive = true
        showImage.widthAnchor.constraint(lessThanOrEqualTo: cellContainerView.widthAnchor, multiplier: 1).isActive = true
    }
    
    func setTitleConstraints() {
        showLabel.topAnchor.constraint(equalTo: showImage.bottomAnchor, constant: 12).isActive = true
        showLabel.bottomAnchor.constraint(equalTo: cellContainerView.bottomAnchor, constant: 12).isActive = true
        showLabel.centerXAnchor.constraint(equalTo: cellContainerView.centerXAnchor).isActive = true
        showLabel.widthAnchor.constraint(lessThanOrEqualTo: cellContainerView.widthAnchor, multiplier: 1).isActive = true
        showLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
