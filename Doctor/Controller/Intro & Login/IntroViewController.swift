//
//  LoginVC.swift
//  Doctor
//
//  Created by Minh Nguỵn on 14/8/24.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var viewCollection: UIView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var createAccountButton: UIButton!
    
    var currentPageIndex = 0
    let introData: [IntroLogin] = [
        IntroLogin(image: "img_intro_0", title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", subTitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
        IntroLogin(image: "img_intro_1", title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", subTitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà"),
        IntroLogin(image: "img_intro_0", title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", subTitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà")
        ]



    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "IntroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "IntroCollectionViewCell")
        setupUI()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let vc = LoginViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupUI() {
        loginButton.layer.cornerRadius = 24
        loginButton.clipsToBounds = true
        collectionView.clipsToBounds = true
        createAccountButton.layer.cornerRadius = 24
        createAccountButton.layer.borderWidth = 1
        pageControl.numberOfPages = introData.count
    }
}

extension IntroViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return introData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCollectionViewCell", for: indexPath) as! IntroCollectionViewCell
        let introItem = introData[indexPath.row]
        cell.setupData(introLogin: introItem)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

extension IntroViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
        if currentPage != currentPageIndex {
            if currentPage >= 0 && currentPage < introData.count {
                currentPageIndex = currentPage
                pageControl.currentPage = currentPage
            }
        }
    }
}
