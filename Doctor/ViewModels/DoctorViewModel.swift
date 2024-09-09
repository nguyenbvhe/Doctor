//
//  DoctorViewModel.swift
//  BSGNProject
//
//  Created by Linh Thai on 16/08/2024.
//

import Foundation
import UIKit

class DoctorViewModel {
    var doctors: [Doctor] = []
    var listDoctor: [DoctorItem] = []
    // Tạo một dictionary để lưu trữ ảnh của các doctor
    var doctorImages: [Int: UIImage] = [:]
    var onDataFetched: (() -> Void)?
    var onError: ((String) -> Void)?
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
    
    
    func fetchDoctorItems() {
        DoctorListService().fetchDoctorData(success: { [weak self] response in
            self?.listDoctor = response.data?.items ?? []
            self?.onDataFetched?()
        }, failure: { [weak self] code, message in
            self?.onError?(message)
        })
    }
}
