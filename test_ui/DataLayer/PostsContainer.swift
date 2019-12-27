//
//  PostsContainer.swift
//  test_ui
//
//  Created by Dimas on 27.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit

class PostsContainer: Codable {
	var posts:[PostItem]
	
	init(posts:[PostItem]) {
		self.posts = posts
	}
	
}
