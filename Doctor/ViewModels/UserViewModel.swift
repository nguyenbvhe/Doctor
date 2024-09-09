//
//  UserViewModel.swift
//  DoctorProject
//
//  Created by Minh Nguyễn on 29/08/2024.
//

import Foundation
import UIKit

class UserViewModel {
    var users: [UserInfoData] = []  // Lưu trữ danh sách người dùng
    var userAvatars: [Int: UIImage] = [:]  // Lưu trữ hình đại diện của người dùng theo ID
    var onDataFetched: (() -> Void)?  // Closure gọi khi dữ liệu đã được tải xong
    var onError: ((String) -> Void)?  // Closure gọi khi có lỗi xảy ra
    let userService = UserService()  // Thể hiện của UserService
    
    // Hàm tải hình đại diện người dùng từ URL
    private func loadUserAvatars() {
        for user in users {
            guard let url = URL(string: user.avatar ?? "") else { continue }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil, let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.userAvatars[user.id ?? 0] = image
                }
            }.resume()
        }
    }
    
    // Hàm lấy dữ liệu người dùng từ API
    func fetchUserItems() {
        UserService.fetchUserNews { [weak self] result in
            switch result {
            case .success(let response):
                if let userData = response.data {
                    self?.users = [userData]  // Chúng ta lưu `UserInfoData` trực tiếp vào danh sách `users`
                    self?.onDataFetched?()
                } else {
                    self?.onError?("No user data found.")
                }
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
