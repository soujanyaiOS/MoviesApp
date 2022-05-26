//
//  BUndleExtensions.swift
//  MovieApp
//
//  Created by soujanya Balusu on 26/05/22.
//

import Foundation
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, with ext: String = "json") -> T? {
        guard let path = self.path(forResource: file, ofType: ext) else {
            return nil
        }

        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            return nil
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch let DecodingError.keyNotFound(key, context) {
            debugPrint("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch let DecodingError.typeMismatch(_, context) {
            debugPrint("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch let DecodingError.valueNotFound(type, context) {
            debugPrint("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            debugPrint("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            debugPrint("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
        return nil
    }
}
