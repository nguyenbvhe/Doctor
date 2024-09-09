import Foundation

struct UserInfoResponse: Decodable {
    let status: Int?
    let message: String?
    let code: Int?
    let data: UserInfoData?
}

struct UserInfoData: Codable {
    let id: Int?
    let name, lastName, username, contactEmail: String?
    let phone, cardID, address: String?
    let provinceCode, districtCode, wardCode: String?
    let latitude, longitude: Double?
    let birthDate, avatar: String?
    let degree, trainingPlace, academicRank: String?
    let majorsID: Int?
    let hospitalName: String?
    let sex, blood: Int?
    let descriptionSelf, verifiedAt: String?
    let currentStep, userType: Int?
    let referCode: String?
    let workingHourType, balance: Int?
    let ratioStar: Double?
    let numberOfReviews, numberOfStars, status, isFirstLogin: Int?
    let createdAt, updatedAt, fullAddress, fullName: String?
    let orderCancelTotal, referralTotal, totalAppointment: Int?
    let bloodName: String?

    enum CodingKeys: String, CodingKey {
        case id, name, lastName = "last_name", username
        case contactEmail = "contact_email"
        case phone, cardID = "card_id", address
        case provinceCode = "province_code"
        case districtCode = "district_code"
        case wardCode = "ward_code"
        case latitude, longitude, birthDate = "birth_date"
        case avatar, degree, trainingPlace = "training_place"
        case academicRank = "academic_rank"
        case majorsID = "majors_id"
        case hospitalName = "hospital_name"
        case sex, blood, descriptionSelf = "description_self"
        case verifiedAt = "verified_at"
        case currentStep = "current_step"
        case userType = "user_type"
        case referCode = "refer_code"
        case workingHourType = "working_hour_type"
        case balance, ratioStar = "ratio_star"
        case numberOfReviews = "number_of_reviews"
        case numberOfStars = "number_of_stars"
        case status, isFirstLogin = "is_first_login"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case fullAddress = "full_address"
        case fullName = "full_name"
        case orderCancelTotal = "order_cancel_total"
        case referralTotal = "referral_total"
        case totalAppointment = "total_appointment"
        case bloodName = "blood_name"
    }
}
