//
//  CodableHelper.swift
//  test_ui
//
//  Created by Dimas on 27.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit

class CodableHelper {
	static let defaultDateFormat: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}()
	
	static func decode<T>(_ data:Data)->T? where T : Codable{
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .formatted(self.defaultDateFormat)
		do{
			let result = try decoder.decode(T.self, from: data)
			return result
		}
		catch let error{
			print("Failed decode: \(error)")
		}
		return nil
		
	}
	static func encode<T>(_ item:T) -> Data? where T : Codable{
		let decoder = JSONEncoder()
		decoder.dateEncodingStrategy =  .formatted(self.defaultDateFormat)
		return try? decoder.encode(item)
	}
	
}
