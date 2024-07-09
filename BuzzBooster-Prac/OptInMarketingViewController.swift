//
//  OptInMarketingViewController.swift
//  BuzzBooster-Prac
//
//  Created by Hyungjun KIM on 7/8/24.
//

import UIKit
import BuzzBoosterSDK
import SnapKit
import Then

final class OptInMarketingViewController: UIViewController {
    
    var textView = UILabel().then {
        $0.text = "This is Sample App's Opt In Marketing Page"
        $0.textColor = .systemBlue
    }
    
    var optInMarketingBtn = UIButton(type: .system).then {
        $0.setTitle("Opt In Marketing? Click this.", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    var backBtn = UIButton(type: .system).then {
        $0.setTitle("Go Back", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 8
        $0.setTitleColor(.white, for: .normal)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
        bindEvent()
    }

    func setupUI() {
        view.addSubview(textView)
        view.addSubview(optInMarketingBtn)
        view.addSubview(backBtn)
    }

    func setupLayout() {
        textView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(view.layoutMarginsGuide.snp.top)
            $0.height.equalTo(48)
        }
        
        optInMarketingBtn.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(textView.snp.bottom)
            $0.height.equalTo(48)
        }
        
        backBtn.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.layoutMarginsGuide)
            $0.top.equalTo(optInMarketingBtn.snp.bottom)
            $0.height.equalTo(48)
        }
    }
    
    func bindEvent() {
        optInMarketingBtn.addTarget(self, action: #selector(optInMarketingBtnAction), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
    }
    
    @objc func optInMarketingBtnAction() {
        BuzzBooster.sendEvent("bb_opt_in_marketing")
    }
    
    @objc func backBtnAction() {
        dismiss(animated: true)
    }
}
