import Foundation
import UIKit

class NewDetailViewModel {
    var newDetailItems: [Item] = []
    var errorMessage: String?
    
    // Dictionary để lưu trữ ảnh của các promotional items
    var newDetailImages: [Int: UIImage] = [:]
    
    let newDetailService = BaseNewDetailService()  // service để lấy dữ liệu NewDetailService
    
    // Closure để thông báo khi dữ liệu đã được tải
    var onDataFetched: (() -> Void)?
    
    func fetchNewDetailItems() {
        newDetailService.fetchNewDetailItems(success: { NewDetailResponse in
            self.newDetailItems = NewDetailResponse.listTtems ?? []
            self.loadNewDetailImages()
            self.onDataFetched?()
        }, failure: { code, message in
            self.errorMessage = message
            print("ERROR \(code): \(message)")
            if let errorMessage = self.errorMessage {
                print("Error message from service: \(errorMessage)")
            }
            
        })
    }
    
    //
    //    private func loadNewDetailImages() {
    //        for item in newDetailItems {
    //            guard let url = URL(string: item.picture) else { continue }
    //
    //            URLSession.shared.dataTask(with: url) { data, response, error in
    //                guard let data = data, error == nil, let image = UIImage(data: data) else {
    //                    return
    //                }
    //                DispatchQueue.main.async {
    //                    self.newDetailImages[item.id] = image
    //                }
    //            }.resume()
    //        }
    //    }
    //}
    private func loadNewDetailImages() {
        for item in newDetailItems {
            guard let url = URL(string: item.picture ?? "") else {
                print("Invalid URL: \(item.picture)")
                continue
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Failed to load image for item \(item.id): \(error.localizedDescription)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to decode image data for item \(item.id)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.newDetailImages[item.id ?? 0] = image
                }
            }.resume()
        }
    }
}
