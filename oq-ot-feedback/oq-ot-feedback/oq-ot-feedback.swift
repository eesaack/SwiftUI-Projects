//
//  oq_ot_feedbackApp.swift
//  oq-ot-feedback
//
//  Created by eesaack on 02/08/2023.
//

import UIKit
import SnapKit

class FeedbackController: UIViewController {
    
    private struct Constants {
        static let ratingViewHeight: CGFloat = 40
        static let ratingLabelTop: CGFloat = 12
        static let commentViewHeight: CGFloat = 120
    }
    
    private let titleLabel = UILabel(typography: .title3)
    private let subtitleLabel = UILabel(typography: .body1, color: .secondaryText)
    private let customConstraint: CGFloat = 32.0
    private let ratingView = RatingView()
    private let ratingLabel = UILabel(typography: .body2, color: .secondaryText)
    private let noteView = NoteView()
    private let commentTextView = UITextView()
    private let submitButton = RoundedButton(style: .accent)
    private var readyBottom: Constraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(ratingView)
        view.addSubview(ratingLabel)
        view.addSubview(noteView)
        view.addSubview(commentTextView)
        view.addSubview(submitButton)
        
        
        titleLabel.text = tr.feedback.title
        subtitleLabel.text = tr.feedback.subtitle
        ratingLabel.text = tr.feedback.ratingLabel
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        ratingLabel.textAlignment = .center
        commentTextView.translatesAutoresizingMaskIntoConstraints = false
        commentTextView.backgroundColor = UIColor(red: 0.94, green: 0.96, blue: 0.96, alpha: 1)
        commentTextView.layer.cornerRadius = 8.0
        commentTextView.font = UIFont.systemFont(ofSize: 16)
        commentTextView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        submitButton.setTitle(tr.feedback.submitButton, for: .normal)
        noteView.note = tr.feedback.noteView

        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Metric.grandOffset)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Metric.standartOffset)
            make.top.equalTo(titleLabel.snp.bottom).offset(Metric.grandOffset)
        }
        ratingView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Metric.standartOffset)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(customConstraint)
            make.height.equalTo(Constants.ratingViewHeight)
        }
        ratingLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Metric.standartOffset)
            make.top.equalTo(ratingView.snp.bottom).offset(Constants.ratingLabelTop)
        }
        noteView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Metric.standartOffset)
            make.top.equalTo(ratingLabel.snp.bottom).offset(customConstraint)
        }
        commentTextView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Metric.standartOffset)
            make.top.equalTo(noteView.snp.bottom).offset(customConstraint)
            make.height.equalTo(Constants.commentViewHeight)
        }
        submitButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Metric.standartOffset)
            make.top.equalTo(commentTextView.snp.bottom).offset(Metric.grandOffset)
            readyBottom = make.bottom.equalToSuperview().offset(-Metric.standartOffset).constraint
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        if view.safeAreaInsets.bottom > Metric.standartOffset {
            readyBottom?.update(offset: -view.safeAreaInsets.bottom)
        }
    }
}
