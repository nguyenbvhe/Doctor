//
//  DoctorViewModel.swift
//  BSGNProject
//
//  Created by Linh Thai on 16/08/2024.
//

import Foundation
import UIKit

class DoctorViewModel {
    var doctors: [DoctorList] = []
    var errorMessage: String?
    
    // Tạo một dictionary để lưu trữ ảnh của các doctor
    var doctorImages: [Int: UIImage] = [:]
    
    let homeService = HomeService()
    
    func fetchDoctors() {
        homeService.fetchHomeData(success: { homeData in
            self.doctors = homeData.doctorList
            self.loadDoctorImages()
        }, failure: { code, message in
            self.errorMessage = message
        })
    }
    
    private func loadDoctorImages() {
        for doctor in doctors {
            guard let url = URL(string: doctor.avatar) else { continue }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.doctorImages[doctor.id] = image
                }
            }.resume()
        }
    }
}
