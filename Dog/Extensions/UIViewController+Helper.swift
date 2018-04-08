//
//  UIViewController+Helper.swift
//  Dog
//
//  Created by Brian Chung on 8/4/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import UIKit

extension UIViewController {

	func showAlert(title: String = "", message: String = "", animated: Bool = true, destructiveAction: UIAlertAction? = nil) {
		let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)

		alertViewController.addAction(self.getCancelAction())

		if let destructiveAction = destructiveAction {
			alertViewController.addAction(destructiveAction)
		}

		self.present(alertViewController, animated: animated, completion: nil)
	}

	private func getCancelAction() -> UIAlertAction {
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		return cancelAction
	}
}
