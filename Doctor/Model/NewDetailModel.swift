//
//  NewDetailModel.swift
//  Doctor
//
//  Created by Minh Nguỵn on 24/8/24.
//

import Foundation

// MARK: - APINewPromotionalResponse
struct APINewDetailResponse: Codable {
    let status: Int?
    let message: String?
    let code: Int?
    let data: NewDetailResponse?
}

// MARK: - NewDetailResponse
struct NewDetailResponse: Codable {
    let listTtems: [Item]?
    let totalRecord, totalPage, page: Int?

    enum CodingKeys: String, CodingKey {
        case listTtems = "items"
        case totalRecord = "total_record"
        case totalPage = "total_page"
        case page
    }
}

// MARK: - Item
struct Item: Codable {
    let id, categoryID: Int?
    let title, slug, summary, content: String?
    let picture: String?
    let pictureCaption, createdAt, categoryName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case title, slug, summary, content, picture, id, link
        case categoryID = "category_id"
        case pictureCaption = "picture_caption"
        case createdAt = "created_at"
        case categoryName = "category_name"
    }
}
