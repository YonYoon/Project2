//
//  ViewController.swift
//  Project2
//
//  Created by Zhansen Zhalel on 10.01.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var score = 0
    var correctAnswer = 0
    var numberOfQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        button1.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button2.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        button3.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
    }

    func restartGame(action: UIAlertAction! = nil) {
        score = 0
        numberOfQuestions = 0
        
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        numberOfQuestions += 1

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong. That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        if numberOfQuestions < 9 {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        } else {
            
            let ac = UIAlertController(title: "Game Over", message: "Your total score is \(score)", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame))
            
            present(ac, animated: true)
        }
    }
    
    @objc func showScore() {
        let vc = UIActivityViewController(activityItems: ["My score is \(score)/\(numberOfQuestions)"], applicationActivities: [])
        vc.popoverPresentationController?.sourceItem = navigationItem.rightBarButtonItem
//        let ac = UIAlertController(title: "Total score is \(score)/\(numberOfQuestions)", message: nil, preferredStyle: .alert)
//        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(vc, animated: true)
    }
}

