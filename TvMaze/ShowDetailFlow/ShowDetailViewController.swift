//
//  ShowDetailViewController.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import UIKit

class ShowDetailViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.primary
        return label
    }()
    
    lazy var averageRatingLabel: UILabel = {
        let label =  UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.label
        return label
    }()
    
    lazy var showImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.setupRoundedCorners(radius: 16)
        return image
    }()
    
    lazy var descriptionView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.textAlignment = .left
        textView.setupRoundedCorners(radius: 14)
        return textView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "close")?.withRenderingMode(.alwaysTemplate)
        let imageTintColor = UIColor.primary
        let barButtonBackgrounColor = UIColor.background
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = imageTintColor
        button.makeItCircular()
        button.backgroundColor = barButtonBackgrounColor
        button.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let viewModel: ShowDetailViewModel
    
    init(with viewModel: ShowDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        setUI()
    }
    
    @objc
    func closeButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func setConstraints() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(averageRatingLabel)
        view.addSubview(showImage)
        view.addSubview(descriptionView)
        setCloseButtonConstraints()
        setLabelTitleConstraints()
        setShowImageConstraints()
        setRatingConstraints()
        setRatingConstraints()
        setTextViewConstraints()
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.background
        titleLabel.text = viewModel.show.name
        averageRatingLabel.text = "Rating: " + String(viewModel.show.rating)
        showImage.loadImage(withUrl: viewModel.show.image)
        descriptionView.attributedText = viewModel.show.summary.htmlToAttributedString
    }
}

extension ShowDetailViewController {
    func setCloseButtonConstraints() {
        closeButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        closeButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setLabelTitleConstraints() {
        titleLabel.topAnchor.constraint(equalTo: showImage.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: showImage.trailingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1).isActive = true
    }
    
    func setShowImageConstraints() {
        showImage.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 20).isActive = true
        showImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        showImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        showImage.heightAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func setRatingConstraints() {
        averageRatingLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1).isActive = true
        averageRatingLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        averageRatingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        averageRatingLabel.bottomAnchor.constraint(equalTo: showImage.bottomAnchor).isActive = true
    }
    
    func setTextViewConstraints() {
        descriptionView.topAnchor.constraint(equalTo: showImage.bottomAnchor, constant: 25).isActive = true
        descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        descriptionView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1).isActive = true
    }
}
