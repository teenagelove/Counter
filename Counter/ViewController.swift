//
//  ViewController.swift
//  Counter
//
//  Created by Danil Kazakov on 04.10.2024.
//

import UIKit

final class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var historyTextView: UITextView!
    
    private var counter: Int = 0 {
        didSet {
            updateLabel()
            updateResetButtonState()
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        configureTextView()
        configureResetButton()
    }
    
    private func configureTextView() {
        historyTextView.text = "История изменений: \n"
        historyTextView.textAlignment = .center
        historyTextView.isEditable = false
        historyTextView.isScrollEnabled = true
    }
    
    private func configureResetButton() {
        resetButton.isEnabled = false
    }
    
    private func updateLabel() {
        counterLabel.text = "\(counter)"
    }
    
    private func updateResetButtonState() {
        resetButton.isEnabled = !(counter == 0)
    }
    
    private func appendToHistory(message: String) {
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        historyTextView.text.append("\(formattedDate): \(message) \n")
    }
    
    private func changeCounter(_ action: CounterAction) {
        var message: String
        
        switch action {
        case .increase:
            counter += 1
            message = "значение изменено на +1"
        case .decrease:
            if counter > 0 {
                counter -= 1
                message = "значение изменено на -1"
            } else {
                message = "попытка уменьшить значение счётчика ниже 0"
            }
        case .reset:
            counter = 0
            message = "значение сброшено"
        }
        
        appendToHistory(message: message)
    }
    
    @IBAction func plusButtonDidTap(_ sender: UIButton) {
        changeCounter(.increase)
    }
    
    @IBAction func minusButtonDidTap(_ sender: UIButton) {
        changeCounter(.decrease)
    }
    
    @IBAction func resetButtonDidTap(_ sender: UIButton) {
        changeCounter(.reset)
    }
}

