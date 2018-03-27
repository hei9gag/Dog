//
//  DogPickerViewController.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import UIKit
import PinLayout

class DogPickerViewController: UIViewController {

	@IBOutlet weak var selectButton: UIButton!
	@IBOutlet weak var dogNameLabel: UILabel!
	@IBOutlet weak var dogPickerView: UIPickerView!
	var loadingView: LoadingView!

	var pickerData: [String] = [String]()

	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
	}

	private func setupUI() {
		self.loadingView = LoadingView()
		self.view.addSubview(self.loadingView)
		self.loadingView.pin.all()
		
		// Connect data:
		self.dogPickerView.delegate = self
		self.dogPickerView.dataSource = self

		// Do any additional setup after loading the view.
		self.pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
	}
}

extension DogPickerViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		 return pickerData[row]
	}
}

extension DogPickerViewController: UIPickerViewDataSource {
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.pickerData.count
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
}
