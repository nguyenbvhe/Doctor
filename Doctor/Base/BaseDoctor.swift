import Foundation
import Alamofire

// Service Class
class DoctorListService: DoctorService {
    let doctorURL = "https://gist.github.com/CanThaiLinh/c166341bf5c5a1f9f417656598013bc9/raw"
    
    func fetchDoctorData(success: @escaping (DoctorsResponse) -> Void, failure: @escaping (_ code: Int, _ message: String) -> Void) {
        DoctorListService.request(url: doctorURL, responseType: DoctorsResponse.self, success: { response in
            success(response)
            if let items = response.data?.items {
                print("Fetched \(items.count) items.")
            } else {
                print("No items found.")
            }
        }, failure: { code, message in
            failure(code, message)
            print("ERROR \(code): \(message)")
        })
    }
}

class DoctorService: BaseSevice2 {
    static func fetchDoctorNews(completion: @escaping (Result<DoctorsResponse, AFError>) -> Void) {
        let url = "https://gist.github.com/CanThaiLinh/c166341bf5c5a1f9f417656598013bc9/raw"
        BaseSevice2.request(url: url, responseType: DoctorsResponse.self, success: { response in
            print("Data fetched successfully: \(response)")
            completion(.success(response))
        }, failure: { code, message in
            print("Failed to fetch data with error: \(message)")
            completion(.failure(AFError.explicitlyCancelled))
        })
    }
}
