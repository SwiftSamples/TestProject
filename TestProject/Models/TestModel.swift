//
//  TestModel.swift
//  TestProject
//
//  Created by Swapna Botta on 17/07/23.
//

import Foundation


// MARK: - TestAPIModel
struct TestAPIModel: Codable {
    let page, perPage, total, totalPages: Int
    var data: [Datum]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name: String
    let year: Int
    let color, pantoneValue: String
    var isSelected: Bool = false
    enum CodingKeys: String, CodingKey {
        case id, name, year, color
        case pantoneValue = "pantone_value"
       // case isSelected = "is_selected"

    }
}

// MARK: - Support
struct Support: Codable {
    let url: String
    let text: String
}


//-------------------------------------------------------------------------------------

struct APIResponseStructure: Codable {
    let jsonrpc: String
    let result: ResultData
}

struct ResultData: Codable {
    let key: String
    let value: Value
}

enum Value: Codable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case array([Value])
    case dictionary([String: Value])
    
    enum CodingKeys: String, CodingKey {
        case stringValue
        case intValue
        case doubleValue
        case boolValue
        case arrayValue
        case dictionaryValue
    }
    
    enum ValueType: String, Codable {
        case string, int, double, bool, array, dictionary
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? container.decode(String.self, forKey: .stringValue) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self, forKey: .intValue) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self, forKey: .doubleValue) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self, forKey: .boolValue) {
            self = .bool(value)
        } else if let value = try? container.decode([Value].self, forKey: .arrayValue) {
            self = .array(value)
        } else if let value = try? container.decode([String: Value].self, forKey: .dictionaryValue) {
            self = .dictionary(value)
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: container.codingPath, debugDescription: "Invalid value"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value):
            try container.encode(value, forKey: .stringValue)
        case .int(let value):
            try container.encode(value, forKey: .intValue)
        case .double(let value):
            try container.encode(value, forKey: .doubleValue)
        case .bool(let value):
            try container.encode(value, forKey: .boolValue)
        case .array(let value):
            try container.encode(value, forKey: .arrayValue)
        case .dictionary(let value):
            try container.encode(value, forKey: .dictionaryValue)
        }
    }
}
