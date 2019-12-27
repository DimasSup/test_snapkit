//
//  StringsHelper.swift
//  test_ui
//
//  Created by Dimas on 27.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit
extension NSAttributedString.Key{
	static var TagColor:NSAttributedString.Key = {
		return NSAttributedString.Key("Tag_Color")
	}()
	static var TagFontStyle:NSAttributedString.Key = {
		return NSAttributedString.Key("Tag_Font")
	}()
	
	static var UserColor:NSAttributedString.Key = {
		return NSAttributedString.Key("User_Color")
	}()
	static var UserFontStyle:NSAttributedString.Key = {
		return NSAttributedString.Key("User_Font")
	}()
	
	
}
class StringsHelper {
	
	
	
	enum StringHelperErrors:Error{
		case noFont
	}
	
	public static var defaultMessageStyle:[NSAttributedString.Key:Any] = {
		var styles = [NSAttributedString.Key:Any]()
		styles[.foregroundColor] = UIColor.black
		styles[.font] = UIFont(name: "HelveticaNeue", size: 14)
		styles[.TagColor] = UIColor(red:0.00, green:0.70, blue:1.00, alpha:1.0)
		
		styles[.UserColor] = UIColor.black
		styles[.UserFontStyle] = UIFontDescriptor.SymbolicTraits(arrayLiteral: .traitBold)
		return styles
	}()
	private static func clearAttributes(_ attr:[NSAttributedString.Key:Any])->[NSAttributedString.Key:Any]{
		var clearedAttributes = attr
		clearedAttributes[.TagFontStyle] = nil
		clearedAttributes[.TagColor] = nil
		clearedAttributes[.UserColor] = nil
		clearedAttributes[.UserFontStyle] = nil
		return clearedAttributes
	}
	public static func makeLikesString(likesCount:Int,friends:[String]?) -> NSAttributedString{
		let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
		let font = UIFont(name: "HelveticaNeue", size: 14) ?? UIFont.systemFont(ofSize: 14)
		let color = UIColor.black
		let result = NSMutableAttributedString()
		if let friends = friends,friends.count > 0{
			result.append(NSAttributedString(string: "Liked by ",attributes: [.font:font,.foregroundColor:color]))
			let count = min(friends.count,3)
			for index in 0 ..< count{
				if index > 0{
					result.append(NSAttributedString(string: ", ",attributes: [.font:font,.foregroundColor:color]))
				}
				result.append(NSAttributedString(string: friends[index],attributes: [.font:boldFont,.foregroundColor:color]))
			}
			let otherCount = likesCount - count
			if otherCount > 0{
				result.append(NSAttributedString(string:" and ",attributes: [.font:font,.foregroundColor:color]))
				result.append(NSAttributedString(string:"\(otherCount) others",attributes: [.font:boldFont,.foregroundColor:color]))
			}
		}
		else{
			
			result.append(NSAttributedString(string: "\(likesCount) likes",attributes: [.font:boldFont,.foregroundColor:color]))
		}
		return result
	}
	
	public static func makeMessageAttributeString(_ userName:String,text:String,style:[NSAttributedString.Key:Any] = defaultMessageStyle) throws -> NSAttributedString{
		guard let font = style[.font] as? UIFont else{
			throw StringHelperErrors.noFont
		}
		var clearedAttributes = self.clearAttributes(style)
		
		
		
		let result = NSMutableAttributedString(string: " " + text,attributes: clearedAttributes)
		
		var userNameAttribute = clearedAttributes
		if let color = style[.UserColor] as? UIColor{
			userNameAttribute[.foregroundColor] = color
		}
		if let trait = style[.UserFontStyle] as? UIFontDescriptor.SymbolicTraits,let copyDescriptor = font.fontDescriptor.withSymbolicTraits(trait){
			userNameAttribute[.font] =  UIFont(descriptor: copyDescriptor, size: 0)
		}
		result.insert(NSAttributedString(string: userName, attributes: userNameAttribute), at: 0)
		
		let color = style[.TagColor] as? UIColor
		let tagStyle = style[.TagFontStyle] as? UIFontDescriptor.SymbolicTraits
		if color != nil || tagStyle != nil {
			var addAttributes = [NSAttributedString.Key:Any]()
			if color != nil{
				addAttributes[.foregroundColor] = color!
			}
			if tagStyle != nil,let copyDescriptor = font.fontDescriptor.withSymbolicTraits(tagStyle!){
				addAttributes[.foregroundColor] = UIFont(descriptor: copyDescriptor, size: 0)
			}
			
			let expression = try! NSRegularExpression(pattern: "(@\\w+)|(#\\w+)", options: .init(rawValue: 0))
			let matches = expression.matches(in: result.string, options: .reportCompletion, range: NSRange(location: userName.count, length: result.string.count - userName.count))
			for match in matches{
				result.addAttributes(addAttributes, range: match.range(at: 0))
			}
		}
		
		return result
	}
	
}

extension StringsHelper{
	static var dateFormatter:DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .medium
		formatter.timeStyle = .short
		return formatter
	}()
	public static func formatDate(_ date:Date)->String{
		return self.dateFormatter.string(from: date)
	}
}
