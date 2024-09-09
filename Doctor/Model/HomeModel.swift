import Foundation
struct APIModel: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: HomeData
    
}
// MARK: - HomeData
struct HomeData: Codable {
    let articleList: [Article]
    let promotionList: [Promotion]
    let doctorList: [Doctor]
}

// MARK: - ArticleList
struct Article: Codable {
    let id, categoryID: Int
    let title, slug: String
    let picture: String
    let pictureCaption, createdAt, categoryName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title, slug, picture
        case pictureCaption = "picture_caption"
        case createdAt = "created_at"
        case categoryName = "category_name"
        case link
    }
}

// MARK: - DoctorList
struct Doctor: Codable {
    let id: Int
    let fullName, name, lastName, contactEmail: String
    let phone: String
    let avatar: String
    let majorsName: String
    let ratioStar: Double
    let numberOfReviews, numberOfStars: Int

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case name
        case lastName = "last_name"
        case contactEmail = "contact_email"
        case phone, avatar
        case majorsName = "majors_name"
        case ratioStar = "ratio_star"
        case numberOfReviews = "number_of_reviews"
        case numberOfStars = "number_of_stars"
    }
}

// MARK: - PromotionList
struct Promotion: Codable {
    let id, categoryID: Int
    let code, name, slug, content: String
    let picture: String
    let fromDate, toDate: String
    let amount, type, kind: Int
    let createdAt, categoryName, amountText: String
    let link: String
    let isBookmark: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case code, name, slug, content, picture
        case fromDate = "from_date"
        case toDate = "to_date"
        case amount, type, kind
        case createdAt = "created_at"
        case categoryName = "category_name"
        case amountText = "amount_text"
        case link
        case isBookmark = "is_bookmark"
    }
}
