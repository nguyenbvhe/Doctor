//
//  Protocol.swift
//  Doctor
//
//  Created by Minh Nguỵn on 28/8/24.
//

import Foundation
import UIKit

protocol ArticleTableViewCellDelegate: AnyObject {
    func didTapSeeAllArticles()
    func didTapArticle(with link: String)
}

protocol PromotionTableViewCellDelegate: AnyObject {
    func didTapSeeAllPromotions()
}

protocol DoctorTableViewCellDelegate: AnyObject {
    func didTapSeeAllDoctors()
}
protocol DoneButtonTableViewCellDelegate: AnyObject {
    func popDidTapped()
}
