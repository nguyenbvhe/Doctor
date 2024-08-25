//
//  PromotionViewModel.swift
//  BSGNProject
//
//  Created by Linh Thai on 16/08/2024.
//

import Foundation
import UIKit

class PromotionViewModel {
    var promotions: [PromotionList] = []

    var promotionImages: [Int: UIImage] = [:]
    
    let homeService = HomeService()
    
    
    private func loadPromotionImages() {
        for promotion in promotions {
            guard let url = URL(string: promotion.picture) else { continue }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.promotionImages[promotion.id] = image
                }
            }.resume()
        }
    }
}


