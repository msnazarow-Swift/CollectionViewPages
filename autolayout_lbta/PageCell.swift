//
//  PageCell.swift
//  autolayout_lbta
//
//  Created by out-nazarov2-ms on 15.09.2021.
//  Copyright © 2021 Lets Build That App. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    var page: Page? {
        didSet{
            guard let page = page else {
                return
            }
            let attributedText = NSMutableAttributedString(string:  page.headerText, attributes: [.font: UIFont.boldSystemFont(ofSize: 26)])
            attributedText.append(NSAttributedString(string: "\r\r\(page.bodyText)", attributes: [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.gray]))
            bearImageView.image = UIImage(named: page.imageName)
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    private let bearImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
        // this enables autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string:  "Join us today in our fun and games!", attributes: [.font: UIFont.boldSystemFont(ofSize: 26)])
        attributedText.append(NSAttributedString(string: "\r\rAre you ready for loads and loads for fun?\rDon't wait any longer!\rWe hope to see you in our stores soon.", attributes: [.font: UIFont.systemFont(ofSize: 20), .foregroundColor: UIColor.gray]))
//        textView.text = "Join us today in our fun and games!"

        textView.attributedText = attributedText
        textView.adjustsFontForContentSizeCategory = true
//        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        return textView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .purple
        addSubview(descriptionTextView)
        setupLayout()
    }

    private func setupLayout() {
        let topImageContainerView = UIView()
        topImageContainerView.addSubview(bearImageView)
//        topImageContainerView.backgroundColor = .blue
        addSubview(topImageContainerView)

//        topImageContainerView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        bearImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        bearImageView.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        bearImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bearImageView.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true

        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
