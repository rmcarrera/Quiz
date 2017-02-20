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
        let answer: String = answers[currentQuestionIndex]
        answerLabel.text = answer
    }
    
    func animateLabelTransitions(){
        /* let animateClosure = { () -> Void in
         self.questionLabel.alpha = 1
         }
         
         //Animate the alpha
         UIView.animate(withDuration: 0.5, animations: animateClosure)*/
        /*UIView.animate(withDuration: 0.5, animations: {
         self.currentQuestionLabel.alpha = 0
         self.nextQuestionLabel.alpha = 1})
         */
        view.layoutIfNeeded()
        //animate the alpha and center X constriants
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstriant.constant = 0
        self.currentQuestionLabelCenterXConstriant.constant += screenWidth
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear], animations: {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()}, completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstriant,
                     &self.nextQuestionLabelCenterXConstriant)
                self.updateOffScreenLabel()
        })
        
       /* UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: nil, animations:  {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
            self.view.layoutIfNeeded()}, completion: { _ in
                swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                swap(&self.currentQuestionLabelCenterXConstriant,
                     &self.nextQuestionLabelCenterXConstriant)
                self.updateOffScreenLabel()
        })*/
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstriant.constant = -screenWidth
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //set the label's initial alpha
        nextQuestionLabel.alpha = 0
    }
    
    
}

