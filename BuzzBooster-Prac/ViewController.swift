//
//  ViewController.swift
//  BuzzBooster-Prac
//
//  Created by Hyungjun KIM on 7/8/24.
//

import UIKit
import BuzzBoosterSDK
import SnapKit
import Then

class ViewController: UIViewController {
    var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    var loginBtn = UIButton(type: .system).then {
        $0.setTitle("Login", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var showInAppMessageBtn = UIButton(type: .system).then {
        $0.setTitle("showInAppMessage", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var showHomeBtn = UIButton(type: .system).then {
        $0.setTitle("showCampaign", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var showAttendanceCampaignBtn = UIButton(type: .system).then {
        $0.setTitle("showAttendanceCampaign", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var likeBtn = UIButton(type: .system).then {
        $0.setTitle("like", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var postBtn = UIButton(type: .system).then {
        $0.setTitle("post", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var commentBtn = UIButton(type: .system).then {
        $0.setTitle("comment", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var stampActionStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    var lightThemeBtn = UIButton(type: .system).then {
        $0.setTitle("light", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
      }
      
    var darkThemeBtn = UIButton(type: .system).then {
        $0.setTitle("dark", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var systemThemeBtn = UIButton(type: .system).then {
        $0.setTitle("system", for: .normal)
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var userInterfaceStyleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 5
    }
    
    var userInterfaceStyleLabel = UILabel().then {
        $0.textColor = .white
        $0.text = "UserInterfaceStyle: System"
    }
    
    var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    var login: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
        bindEvent()
    }

    func setupUI() {
        self.navigationItem.title = "BuzzBooster 가지고 놀기 🎮"
        self.view.backgroundColor = .white
        
        stampActionStackView.addArrangedSubview(likeBtn)
        stampActionStackView.addArrangedSubview(postBtn)
        stampActionStackView.addArrangedSubview(commentBtn)
        
        userInterfaceStyleStackView.addArrangedSubview(lightThemeBtn)
        userInterfaceStyleStackView.addArrangedSubview(darkThemeBtn)
        userInterfaceStyleStackView.addArrangedSubview(systemThemeBtn)
        
        stackView.addArrangedSubview(loginBtn)
        stackView.addArrangedSubview(showInAppMessageBtn)
        stackView.addArrangedSubview(showHomeBtn)
        stackView.addArrangedSubview(showAttendanceCampaignBtn)
        stackView.addArrangedSubview(stampActionStackView)
        stackView.addArrangedSubview(userInterfaceStyleStackView)
        stackView.addArrangedSubview(userInterfaceStyleLabel)
        
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
    }
    
    func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.layoutMarginsGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width).offset(-4)
        }
        
        stackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(48)
            }
        }
    }
    
    func bindEvent() {
        loginBtn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        showInAppMessageBtn.addTarget(self, action: #selector(showInAppMessageBtnAction), for: .touchUpInside)
        showHomeBtn.addTarget(self, action: #selector(showHomeBtnAction), for: .touchUpInside)
        likeBtn.addTarget(self, action: #selector(likeBtnAction), for: .touchUpInside)
        postBtn.addTarget(self, action: #selector(postBtnAction), for: .touchUpInside)
        commentBtn.addTarget(self, action: #selector(commentBtnAction), for: .touchUpInside)
        lightThemeBtn.addTarget(self, action: #selector(lightThemeBtnTapped), for: .touchUpInside)
        darkThemeBtn.addTarget(self, action: #selector(darkThemeBtnTapped), for: .touchUpInside)
        systemThemeBtn.addTarget(self, action: #selector(systemThemeBtnTapped), for: .touchUpInside)
    }
    
    @objc func loginBtnAction(butotn: UIButton!) {
        if self.login {
            BuzzBooster.setUser(nil)
            loginBtn.setTitle("Login", for: .normal)
        }
        else {
            let user = BSTUser { builder in
                builder.userId = AppDelegate.USER_ID
                builder.marketingStatus = .optIn
                builder.properties = ["login_type": "sns(Facebook"]
            }
            BuzzBooster.setUser(user)
            BuzzBooster.showInAppMessage(with: self)
            loginBtn.setTitle("Logout", for: .normal)
        }
        self.login = !self.login
    }
    
    @objc func showInAppMessageBtnAction() {
        BuzzBooster.showInAppMessage(with: self)
    }
    
    @objc func showHomeBtnAction() {
        BuzzBooster.showHome(with: self)
    }
    
    @objc func showAttendanceCampaignListBtnAction() {
        BuzzBooster.showCampaign(by: .attendance, with: self)
    }
    
    @objc func likeBtnAction() {
        BuzzBooster.sendEvent(
            "bb_like",
            values: [
                "like_comment_id": "post_1"
            ]
       )
    }
    
    @objc func commentBtnAction() {
        BuzzBooster.sendEvent(
            "bb_comment",
            values: [
                "commented_content_id": "1",
                "comment": "Great Post!",
            ]
        )
    }
    
    @objc func postBtnAction() {
        BuzzBooster.sendEvent(
            "bb_posting_content",
            values: [
                "posted_content_id": "1",
            ])
    }
    
    @objc private func lightThemeBtnTapped() {
        BuzzBooster.userInterfaceStyle = .light
        userInterfaceStyleLabel.text = "UserInterfaceStyle: LIGHT"
    }
    
    @objc private func darkThemeBtnTapped() {
        BuzzBooster.userInterfaceStyle = .dark
        userInterfaceStyleLabel.text = "UserInterfaceStyle: DARK"
    }
    
    @objc private func systemThemeBtnTapped() {
        BuzzBooster.userInterfaceStyle = .system
        userInterfaceStyleLabel.text = "UserInterfaceStyle: SYSTEM"
    }
}

