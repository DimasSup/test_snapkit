//
//  DataProvider.swift
//  test_ui
//
//  Created by Dimas on 27.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit


public class DataProvider {
	
	public enum LoadResult{
		case ok
		case failed(Error?)
	}

	let filePath:URL
	private var postsContainer:PostsContainer?
	
	init(from filePath:String) {
		self.filePath = URL(fileURLWithPath: filePath)
	}
	
	func load(_ callback:@escaping (_ result:LoadResult)->Void){
		DispatchQueue.global(qos: .background).async {[weak self] in
			guard let self = self else{
				callback(.failed(nil))
				return
			}
			do{
				let data = try Data(contentsOf: self.filePath)
				self.postsContainer = CodableHelper.decode(data)
				callback(.ok)
			}
			catch let error{
				callback(.failed(error))
			}
		}
		
		
	}
	
	func getPosts(callback:@escaping ([PostItem])->Void){
		self.load {[weak self] (result) in
			guard let self = self else{
				callback([])
				return
			}
			callback(self.postsContainer?.posts ?? [])
		}
	}
	
}
