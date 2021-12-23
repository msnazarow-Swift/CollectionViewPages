//
//  SwipingController.swift
//  autolayout_lbta
//
//  Created by out-nazarov2-ms on 15.09.2021.
//  Copyright © 2021 Lets Build That App. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SwipingController: UICollectionViewController {

// MARK: - Properties

    let pages = [
        Page(imageName: "bear_first", headerText: "Join us today in our fun and games!", bodyText: "Are you ready for loads and loads for fun?\rDon't wait any longer!\rWe hope to see you in our stores soon."),
        Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daile events", bodyText: "Get notified of the savings i,,ediately when we announce them on out web site. Make sure to also give uis any feed back uourt have."),
        Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
    ]

    private let previusButton: UIButton =  {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()

    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
//        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .red
        pc.numberOfPages = pages.count
        return pc
    }()

    // MARK: - LiveCircle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.isPagingEnabled = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Register cell classes
        self.collectionView!.register(PageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupButtomControls()
        // Do any additional setup after loading the view.
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        self.collectionViewLayout.invalidateLayout()
        coordinator.animate { (_) in
            self.collectionViewLayout.invalidateLayout()
//            if self.pageControl.currentPage == 0 {
//                self.collectionView?.contentOffset = .zero
//            } else {
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
//        }
//        super.viewWillTransition(to: size, with: coordinator)
    }

    fileprivate func setupButtomControls(){

        let bottomControlsStackView = UIStackView(arrangedSubviews: [previusButton, pageControl, nextButton])
        bottomControlsStackView.distribution = .fillProportionally
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomControlsStackView)

        NSLayoutConstraint.activate([
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 24),
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -24),
            bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func handleNext(){
        pageControl.currentPage += 1
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    @objc private func handlePrev(){
        pageControl.currentPage -= 1
        let indexPath = IndexPath(item: pageControl.currentPage, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension SwipingController: UICollectionViewDelegateFlowLayout {

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
}

extension SwipingController{

    // MARK: UICollectionViewDelegate

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
}
