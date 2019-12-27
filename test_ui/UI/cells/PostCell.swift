//
//  PostCell.swift
//  test_ui
//
//  Created by Dimas on 26.12.2019.
//  Copyright © 2019 T.D.V.DG. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage



class PostCell: UITableViewCell {
	
	
	static let kTopHeight:CGFloat = 44
	
	//MARK: - views
	lazy var contentStack:UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.alignment = .center
		view.backgroundColor = .green
		return view
	}()
	lazy var topView:UIView = UIView()
	lazy var bottomView:UIStackView = {
		let bottomView = UIStackView()
		bottomView.axis = .vertical
		bottomView.backgroundColor = .green
		
		return bottomView
	}()
	lazy var actionsView:UIView = UIView()
	lazy var userAvatar:UIImageView = {
		let img = UIImageView(image: UIImage(named: "menu_dot"))
		img.backgroundColor = UIColor.gray
		img.contentMode = .scaleAspectFill
		img.clipsToBounds = true
		img.layer.cornerRadius = 17
		img.isAccessibilityElement = true
		img.accessibilityIdentifier = "UserAvatar"
		return img
	}()
	lazy var userName:UILabel = {
		let label =	UILabel()
		label.textColor = UIColor.black
		label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
		return label
	}()
	lazy var userLocation:UILabel = {
		let label = UILabel()
		label.textColor = UIColor.gray
		label.font = UIFont(name: "HelveticaNeue", size: 14)
		
		return label
	}()
	lazy var menuButton:UIButton = {[unowned self] in
		let button = UIButton()
		button.setImage(UIImage(named: "menu_dot"), for: .normal)
		button.addTarget(self, action: #selector(onMenuClicked(_:)), for: .touchUpInside)
		return button
		}()
	lazy var contentImageView:UIImageView = {
		let image = UIImageView()
		image.contentMode = .scaleAspectFill
		image.backgroundColor = .lightGray
		return image
	}()
	lazy var likeButton:UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "like_unactive"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		button.accessibilityIdentifier = "LikeIdentifier"
		return button
	}()
	lazy var commentButton:UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "comment_unactive"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		return button
	}()
	lazy var shareButton:UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "send_unactive"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		return button
	}()
	lazy var bookmarkButton:UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "bookmark_unactive"), for: .normal)
		button.imageView?.contentMode = .scaleAspectFit
		button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		return button
	}()
	lazy var likesLineView:UIView = UIView()
	lazy var likesText:UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
	
	lazy var messageText:UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		return label
	}()
	
	lazy var dateText:UILabel = {
		let label = UILabel()
		label.font = UIFont(name: "HelveticaNeue-Medium", size: 11)
		label.textColor = .lightGray
		return label
	}()
	
	//MARK: -
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.setup()
	}
	
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	
	
	func setup(){
		self.selectionStyle = .none
		self.contentView.backgroundColor = .white
		self.contentView.addSubview(self.contentStack)
		self.contentStack.snp.makeConstraints { (maker) in
			maker.size.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
		}
		
		self.makeTopView()
		self.makeContentView()
		self.makeBottomView()
		
		
		
		
	
		
		
	}
	

	var item:PostItem?{
		didSet{
			updateUI()
		}
	}
	
}
//MARK: - Layout
extension PostCell{
	func makeTopView(){
		self.contentStack.addArrangedSubview(topView)
		topView.snp.makeConstraints { (maker) in
			maker.height.equalTo(PostCell.kTopHeight)
			maker.width.equalToSuperview()
		}
		
		topView.addSubview(userAvatar)
		userAvatar.snp.makeConstraints { (maker) in
			maker.size.equalTo(CGSize(width:34,height:34))
			maker.leading.equalTo(topView).offset(10)
			maker.centerY.equalTo(topView)
		}
		
		topView.addSubview(menuButton)
		menuButton.snp.makeConstraints { (maker) in
			maker.width.equalTo(topView.snp.height)
			maker.height.equalTo(topView)
			maker.trailing.equalTo(topView.snp.trailing).offset(-5)
		}
		
		
		let userInfoStackView = UIStackView()
		userInfoStackView.axis = .vertical
		userInfoStackView.distribution = .fillEqually
		topView.addSubview(userInfoStackView)
		userInfoStackView.alignment = .leading
		userInfoStackView.snp.makeConstraints { (maker) in
			maker.height.equalTo(topView).offset(-10)
			maker.centerY.equalTo(topView)
			maker.leading.equalTo(userAvatar.snp.trailing).offset(5)
			maker.trailing.equalTo(menuButton.snp.leading).offset(5)
		}
		
		userInfoStackView.addArrangedSubview(userName)
		userInfoStackView.addArrangedSubview(userLocation)
		
		
	}
	func makeContentView(){
		self.contentStack.addArrangedSubview(contentImageView)
		self.contentImageView.snp.makeConstraints { (maker) in
			maker.width.height.equalTo(self.contentStack.snp.width)
		}
	}
	func makeBottomView(){
		self.contentStack.addArrangedSubview(bottomView)
		bottomView.snp.makeConstraints { (maker) in
			maker.width.equalToSuperview().offset(-20)
		}
		self.makeActionsView()
		self.makeLikesStateView()
		self.makeMessageView()
		self.makeDateView()
		
	}
	func makeActionsView(){
		bottomView.addArrangedSubview(actionsView)
		
		let btnSize = CGSize(width: 34, height: 34)
		
		actionsView.snp.makeConstraints { (maker) in
			maker.height.equalTo(44)
			maker.width.equalToSuperview()
		}
		
		actionsView.addSubview(likeButton)
		likeButton.snp.makeConstraints { (maker) in
			maker.size.equalTo(btnSize)
			maker.centerY.equalToSuperview()
			maker.leading.equalTo(actionsView)
		}
		
		actionsView.addSubview(commentButton)
		commentButton.snp.makeConstraints { (maker) in
			maker.size.equalTo(btnSize)
			maker.centerY.equalToSuperview()
			maker.leading.equalTo(likeButton.snp.trailing).offset(5)
		}
		
		actionsView.addSubview(shareButton)
		shareButton.snp.makeConstraints { (maker) in
			maker.size.equalTo(btnSize)
			maker.centerY.equalToSuperview()
			maker.leading.equalTo(commentButton.snp.trailing).offset(5)
		}
		
		
		actionsView.addSubview(bookmarkButton)
		bookmarkButton.snp.makeConstraints { (maker) in
			maker.size.equalTo(btnSize)
			maker.centerY.equalToSuperview()
			maker.trailing.equalToSuperview()
		}
		
	}
	
	func makeLikesStateView(){
		self.bottomView.addArrangedSubview(likesLineView)
		likesLineView.snp.makeConstraints { (maker) in
			maker.width.equalToSuperview()
			
		}
		likesLineView.addSubview(likesText)
		likesText.snp.makeConstraints { (maker) in
			maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
			
		}
		
	}
	func makeDateView(){
		let rView = UIView()
		self.bottomView.addArrangedSubview(rView)
		rView.snp.makeConstraints { (maker) in
			maker.width.equalToSuperview()
		}
		rView.addSubview(dateText)
		dateText.snp.makeConstraints { (maker) in
			maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 0, bottom: 0, right:0))
			
		}
	}
	func makeMessageView(){
		self.bottomView.addArrangedSubview(messageText)
		messageText.snp.makeConstraints { (maker) in
			maker.width.equalToSuperview()
		}
	}
}

//MARK: - Actions
extension PostCell{
	@objc
	func onMenuClicked(_ sender:Any?){
		
	}
}

//MARK: - UI
extension PostCell{
	func updateUI(){
		guard let item = self.item else{
			return
		}
		self.userAvatar.sd_setImage(with: URL(string: item.userAvatarLink))
		self.userName.text = item.userName
		if item.postLocation != nil{
			self.userLocation.text = item.postLocation
			self.userLocation.isHidden = false
		}
		else{
			self.userLocation.isHidden = true
		}
		if let contentLink = item.contentLinks.first{
			self.contentImageView.sd_setImage(with: URL(string: contentLink),placeholderImage: UIImage(named: "placeholder"))
		}
		else{
			self.contentImageView.image = UIImage(named: "placeholder")
		}
		setupLikesText(item)
		
		if let message = item.title{
			
			self.messageText.attributedText = try? StringsHelper.makeMessageAttributeString(item.userName, text: message)
				
		}
		else{
			self.messageText.attributedText = nil
		}
		self.dateText.text = StringsHelper.formatDate(item.date)
	}
	func setupLikesText(_ item:PostItem){
		if item.likesCount > 0{
			self.likesText.attributedText = StringsHelper.makeLikesString(likesCount: item.likesCount, friends: item.friendsLikes)
		}
		else{
			self.likesText.attributedText = nil
		}
	}
	
}
