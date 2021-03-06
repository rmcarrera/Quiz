//
//  ViewController.swift
//  Quiz
// CSC-2310
//  Created by Roxana Carrera on 1/17/17.
//  Copyright © 2017 Test. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //@IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var currentQuestionLabelCenterXConstriant: NSLayoutConstraint!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstriant: NSLayoutConstraint!
    var widthLayGuide = UILayoutGuide()
    var screenWidth: CGFloat!
    var count: Int = 0
    
    let questions: [String] = [
        "What is 7+7?",
        "What is the capital of Vermont?",
        "What is cognac made from?"
    ]
    let answers: [String] = [
        "14",
        "Montpelier",
        "Grapes"
    ]
    var currentQuestionIndex: Int = 0
    
    @IBAction func showNextQuestion(_ sender: UIButton){
        currentQuestionIndex += 1
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0
        }
        
        let question: String = questions[currentQuestionIndex]
        nextQuestionLabel.text = question
        answerLabel.text = "???"
        
        animateLabelTransitions()
    }
    
    @IBAction func showAnswer(_ sender: UIButton){
        if count%2 != 0{//only go to next answer if odd number of clicks
            let answer: String = answers[currentQuestionIndex]
            answerLabel.text = answer
        }
        else {
            answerLabel.text = "???"
        }
    }
    
    func animateLabelTransitions(){
        view.layoutIfNeeded()
        //animate the alpha and center X constriants
        //let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstriant.constant = 0
        self.currentQuestionLabelCenterXConstriant.constant += screenWidth
        
        /*UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()}, completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstriant,
                     &self.nextQuestionLabelCenterXConstriant)
                self.updateOffScreenLabel()
        })*/
        
        count += 1//increment to odd number

        UIView.animate(withDuration: 0.8, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {self.currentQuestionLabel.alpha = 0
        self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()}, completion: { _ in swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
        swap(&self.currentQuestionLabelCenterXConstriant, &self.nextQuestionLabelCenterXConstriant)
        self.updateOffScreenLabel()
        })
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        screenWidth = view.frame.width
        //Create instance of UIGuide
        self.view.addLayoutGuide(widthLayGuide)
        widthLayGuide.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        currentQuestionLabel.leadingAnchor.constraint(equalTo: widthLayGuide.trailingAnchor).isActive = true
        currentQuestionLabel.trailingAnchor.constraint(equalTo: widthLayGuide.leadingAnchor).isActive = true
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel(){
       // let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstriant.constant = -screenWidth
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
    
}

