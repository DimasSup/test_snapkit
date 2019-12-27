//
//  PostItem.swift
//  test_ui
//
//  Created by Dimas on 27.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit

class PostItem: Codable {
	
	var userName:String
	var userAvatarLink:String
	var postLocation:String?
	
	var contentLinks:[String]
	
	var likesCount:Int
	var commentsCount:Int
	
	var friendsLikes:[String]?
	
	var title:String?
	
	var date:Date
	
}
