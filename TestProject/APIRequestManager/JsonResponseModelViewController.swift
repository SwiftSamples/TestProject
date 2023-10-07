// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let aPIResponseStructure = try? JSONDecoder().decode(APIResponseStructure.self, from: jsonData)

import Foundation

// MARK: - APIResponseStructure
struct APIResponseStructureData: Codable {
    let jsonrpc: String
    let result: ResultJson
}

// MARK: - Result
struct ResultJson: Codable {
    let pageCount, perPageN, postCount: Int
    let userReminder: [UserReminder]

    enum CodingKeys: String, CodingKey {
        case pageCount = "page_count"
        case perPageN = "per_page"
        case postCount = "post_count"
        case userReminder = "UserReminder"
    }
}

// MARK: - UserReminder
struct UserReminder: Codable {
    let id, receiverID: Int
    let type, message, withBoldText, withoutBoldText: String
    let reminderOn, isNotificationForAll, createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case receiverID = "receiver_id"
        case type, message
        case withBoldText = "with_bold_text"
        case withoutBoldText = "without_bold_text"
        case reminderOn = "reminder_on"
        case isNotificationForAll = "is_notification_for_all"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
