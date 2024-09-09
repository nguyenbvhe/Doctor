import Foundation

// MARK: - Root Model
struct NewsResponse: Codable {
    let status: Int?
    let message: String?
    let code: Int?
    let data: NewsData?
}

// MARK: - Data Model
struct NewsData: Codable {
    let items: [NewsItem]
    let totalRecord: Int?
    let totalPage: Int?
    let page: Int?
    
    // Custom CodingKeys to map JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case items
        case totalRecord = "total_record"
        case totalPage = "total_page"
        case page
    }
}

// MARK: - News Item Model
struct NewsItem: Codable {
    let id: Int?
    let categoryID: Int?
    let title: String?
    let slug: String?
    let summary: String?
    let content: String?
    let picture: String
    let pictureCaption: String?
    let createdAt: String?
    let categoryName: String?
    let link: String
    
    // Custom CodingKeys to map JSON keys to Swift properties
    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case title
        case slug
        case summary
        case content
        case picture
        case pictureCaption = "picture_caption"
        case createdAt = "created_at"
        case categoryName = "category_name"
        case link
    }
}
