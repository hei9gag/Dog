//
//  LoadingView.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import UIKit

final class LoadingView: UIView {

	@IBOutlet var contentView: UIView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.commonInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.commonInit()
	}

	private func commonInit() {
		Bundle.main.loadNibNamed(String(describing: LoadingView.self), owner: self, options: nil)
		addSubview(self.contentView)
		self.contentView.frame = self.bounds
		self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
	}
}
