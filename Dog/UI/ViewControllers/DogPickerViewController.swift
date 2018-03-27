//
//  DogPickerViewController.swift
//  Dog
//
//  Created by Brian Chung on 26/3/2018.
//  Copyright © 2018 9GAG. All rights reserved.
//

import UIKit
import PinLayout
import ReactiveCocoa
import ReactiveSwift
import SDWebImage

class DogPickerViewController: UIViewController {

	@IBOutlet weak var moreBreedButton: UIButton!
	@IBOutlet weak var dogImageView: UIImageView!
	@IBOutlet weak var dogNameLabel: UILabel!
	@IBOutlet weak var dogPickerView: UIPickerView!

	fileprivate var viewModel: DogPickerViewModel!
	fileprivate let disposable = CompositeDisposable()

	private var loadingView: LoadingView!

	override func viewDidLoad() {
        super.viewDidLoad()
		self.setupUI()
		self.viewModel = DogPickerViewModel()

		self.reactive.makeBindingTarget(on: UIScheduler(), { [unowned self] (viewController, dogs: [Dog]) in
			self.loadingView.isHidden = !dogs.isEmpty
			self.dogPickerView.isHidden = dogs.isEmpty
			guard !dogs.isEmpty else {
				return
			}
			self.dogNameLabel.text = self.viewModel.getTitleForIndex(0)?.firstUppercased
			self.disposable += self.viewModel.fetchBreedImage(breedName: self.dogNameLabel.text!.lowercased())
			self.dogPickerView.reloadAllComponents()
		}) <~ self.viewModel.dogs.skipRepeats { $0.count == $1.count }

		self.reactive.makeBindingTarget(on: UIScheduler(), { [unowned self] (viewController, dogImages: [URL]) in
			guard !dogImages.isEmpty else {
				return
			}
			self.dogImageView.sd_setImage(with: dogImages[0], placeholderImage: nil)
		}) <~ self.viewModel.dogImages
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	private func setupUI() {
		self.loadingView = LoadingView()
		self.view.addSubview(self.loadingView)
		self.loadingView.pin.all()

		self.dogPickerView.delegate = self
		self.dogPickerView.dataSource = self
		self.dogPickerView.isHidden = true
		self.dogPickerView.backgroundColor = UIColor.lightGray

		self.dogImageView.backgroundColor = UIColor.lightGray
	}

	@objc @IBAction private func userDidTapOnMoreBreed(_ sender: UIButton) {
		let imageUrl = self.viewModel.getNextDogImage()
		self.dogImageView.sd_setImage(with: imageUrl, placeholderImage: nil)
	}
}

extension DogPickerViewController: UIPickerViewDelegate {
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		 return self.viewModel.getTitleForIndex(row)?.firstUppercased
	}
}

extension DogPickerViewController: UIPickerViewDataSource {
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.viewModel.dogs.value.count
	}

	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}

	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.dogNameLabel.text = self.viewModel.getTitleForIndex(row)?.firstUppercased
	}
}
