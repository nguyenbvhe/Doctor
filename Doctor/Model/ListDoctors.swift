import Foundation

// MARK: - DoctorsResponse Model
struct DoctorsResponse: Codable {
    let status: Int?
    let message: String?
    let code: Int?
    let data: DoctorsData?
}

// MARK: - DoctorsData Model
struct DoctorsData: Codable {
    let items: [DoctorItem]
    let totalRecord: Int?
    let totalPage: Int?
    let page: Int?
    
    enum CodingKeys: String, CodingKey {
        case items
        case totalRecord = "total_record"
        case totalPage = "total_page"
        case page
    }
}

// MARK: - DoctorItem Model
struct DoctorItem: Codable {
    let id: Int?
    let fullName: String?
    let name: String?
    let lastName: String?
    let birthDate: String?
    let contactEmail: String?
    let phone: String?
    let avatar: String?
    let bloodName: String?
    let sexName: String?
    let majorsName: String?
    let userTypeName: String?
    let ratioStar: Double?
    let numberOfReviews: Int?
    let numberOfStars: Int?
    let workingHour: String?
    let trainingPlace: String?
    let degree: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case name
        case lastName = "last_name"
        case birthDate = "birth_date"
        case contactEmail = "contact_email"
        case phone
        case avatar
        case bloodName = "blood_name"
        case sexName = "sex_name"
        case majorsName = "majors_name"
        case userTypeName = "user_type_name"
        case ratioStar = "ratio_star"
        case numberOfReviews = "number_of_reviews"
        case numberOfStars = "number_of_stars"
        case workingHour = "working_hour"
        case trainingPlace = "training_place"
        case degree
        case createdAt = "created_at"
    }
}
