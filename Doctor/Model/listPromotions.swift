import Foundation

struct PromotionNewResponse: Decodable {
    let status: Int?
    let message: String?
    let code: Int?
    let data: PromotionalData?
}

struct PromotionalData: Codable {
    let items: [Item]?
    let totalRecord, totalPage, page: Int?

    enum CodingKeys: String, CodingKey {
        case items
        case totalRecord = "total_record"
        case totalPage = "total_page"
        case page
    }
}

struct Item: Codable {
    let id, categoryID: Int?
    let code, name, slug, content: String?
    let picture: String?
    let fromDate, toDate: String?
    let amount, type, kind: Int?
    let createdAt, categoryName: String?
    let link: String?
    let typeName, amountText: String?
    let isBookmark: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case categoryID = "category_id"
        case code, name, slug, content, picture
        case fromDate = "from_date"
        case toDate = "to_date"
        case amount, type, kind
        case createdAt = "created_at"
        case categoryName = "category_name"
        case link
        case typeName = "type_name"
        case amountText = "amount_text"
        case isBookmark = "is_bookmark"
    }
}
