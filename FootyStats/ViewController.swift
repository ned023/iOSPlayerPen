//
//  ViewController.swift
//  FootyStats
//
//  Created by Graeme Kelly on 23/05/2015.
//  Copyright (c) 2015 Graeme Kelly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HomeTeamLabel: UILabel!
    @IBOutlet weak var HomeGoalsLabel: UILabel!
    @IBOutlet weak var HomeBehindsLabel: UILabel!
    @IBOutlet weak var HomePointsLabel: UILabel!

    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var currentQuarterLabel: UILabel!
    @IBOutlet weak var awayGoalsLabel: UILabel!
    @IBOutlet weak var awayBehindsLabel: UILabel!
    @IBOutlet weak var awayPointsLabel: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startQuarter: UIButton!
    
    
    @IBOutlet weak var homeAddGoalButton: UIButton!
    @IBOutlet weak var homeAddBehindButton: UIButton!
    @IBOutlet weak var homeMinusGoalButton: UIButton!
    @IBOutlet weak var homeMinusBehindButton: UIButton!
    @IBOutlet weak var awayAddGoalButton: UIButton!
    @IBOutlet weak var awayAddBehindButton: UIButton!
    @IBOutlet weak var awayMinusGoalButton: UIButton!
    @IBOutlet weak var awayMinusBehindButton: UIButton!
    
    
    
    
    
    var homeGoals = 0
    var homeBehinds = 0
    var homePoints = 0
    var awayGoals = 0
    var awayBehinds = 0
    var awayPoints = 0
    
    var quarterStarted: Bool = false
    var currentQuarter = 0;
    var timer: NSTimer?
    var startTime: NSTimeInterval!


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func startQuarterAction() {
        if (quarterStarted) {
            //Stop the quarter
            switchButtonEnabled(false)
            if (currentQuarter == 1) {
                currentQuarterLabel.text = "Quarter Time"
            } else if (currentQuarter == 2) {
                currentQuarterLabel.text = "Half Time"
            } else if (currentQuarter == 3) {
                currentQuarterLabel.text = "3 Quarter Time"
            } else {
                if (homePoints > awayPoints) {
                    let winner: String = HomeTeamLabel.text!
                      currentQuarterLabel.text = "Congrats \(winner)"
                } else if (awayPoints > homePoints) {
                    let winner: String = awayPointsLabel.text!
                    currentQuarterLabel.text = "Congrats \(winner)"
                } else {
                    currentQuarterLabel.text = "WOW a TIE!"
                }
            }
            startQuarter.setTitle("Start Qtr.", forState: .Normal)
            quarterStarted = false
            timer?.invalidate()
        } else {
            //START THE QUARTER
            switchButtonEnabled(true)
            startTime = NSTimeInterval()
            startQuarter.setTitle("End Qtr.", forState: .Normal)
            currentQuarter += 1
            if (currentQuarter == 1) {
                currentQuarterLabel.text = "1st Quarter"
            } else if (currentQuarter == 2) {
                currentQuarterLabel.text = "2nd Quarter"
            } else if (currentQuarter == 3) {
                currentQuarterLabel.text = "3rd Quarter"
            } else if (currentQuarter == 4) {
                currentQuarterLabel.text = "4th Quarter"
                
            }

            quarterStarted = true
            startTime = NSDate.timeIntervalSinceReferenceDate()
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("updateCounter"), userInfo: nil, repeats: true)
        }
    }
    
    func switchButtonEnabled(enableButton: Bool) {
        homeAddGoalButton?.enabled = enableButton
        homeAddBehindButton?.enabled = enableButton
        homeMinusGoalButton?.enabled = enableButton
        homeMinusBehindButton?.enabled = enableButton
        awayAddGoalButton?.enabled = enableButton
        awayAddBehindButton?.enabled = enableButton
        awayMinusGoalButton?.enabled = enableButton
        awayMinusBehindButton?.enabled = enableButton
        
    }
    
    func updateCounter() {

        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        //Find the difference between current time and start time.
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
        //calculate the minutes in elapsed time.
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        //calculate the seconds in elapsed time.
        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)
        
        //find out the fraction of milliseconds to be displayed.
        //let fraction = UInt8(elapsedTime * 100)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        //let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        timerLabel.text = ("\(strMinutes):\(strSeconds)")
    }
    
    @IBAction func reset() {
        homeGoals = 0
        homeBehinds = 0
        homePoints = 0
        awayGoals = 0
        awayBehinds = 0
        awayPoints = 0
        
        quarterStarted = false
        currentQuarter = 0;

        HomeGoalsLabel.text = "0"
        HomeBehindsLabel.text = "0"
        HomePointsLabel.text = "0"
        awayGoalsLabel.text = "0"
        awayBehindsLabel.text = "0"
        awayPointsLabel.text = "0"
        currentQuarterLabel.text = "Start Game"
        startQuarter.setTitle("Start Qtr.", forState: .Normal)
        timer?.invalidate()
        timerLabel.text = "00:00"
    }
    
    @IBAction func addHomeGoal() {
        homeGoals += 1
        homePoints = homePoints + 6
        HomeGoalsLabel.text = String(homeGoals)
        HomePointsLabel.text = String(homePoints)
    }
    
    @IBAction func minusHomeGoal() {
        if (homeGoals > 0) {
            homeGoals += -1
            homePoints = homePoints - 6
            HomeGoalsLabel.text = String(homeGoals)
            HomePointsLabel.text = String(homePoints)
        }
    }
    
    @IBAction func addHomeBehind() {
        homeBehinds = homeBehinds + 1
        homePoints = homePoints + 1
        HomeBehindsLabel.text = String(homeBehinds)
        HomePointsLabel.text = String(homePoints)
    }
    
    @IBAction func minusHomeBehind() {
        if (homeBehinds > 0) {
            homeBehinds += -1
            homePoints = homePoints - 1
            HomeBehindsLabel.text = String(homeBehinds)
            HomePointsLabel.text = String(homePoints)
        }
    }
    
    @IBAction func addAwayGoal() {
        awayGoals += 1
        awayPoints = awayPoints + 6
        awayGoalsLabel.text = String(awayGoals)
        awayPointsLabel.text = String(awayPoints)
    }
    
    @IBAction func minusAwayGoal() {
        if (awayGoals > 0) {
            awayGoals += -1
            awayPoints = awayPoints - 6
            awayGoalsLabel.text = String(awayGoals)
            awayPointsLabel.text = String(awayPoints)
        }
    }
    
    @IBAction func addAwayBehind() {
        awayBehinds = awayBehinds + 1
        awayPoints = awayPoints + 1
        awayBehindsLabel.text = String(awayBehinds)
        awayPointsLabel.text = String(awayPoints)
    }
    
    @IBAction func minusAwayBehind() {
        if (awayBehinds > 0) {
            awayBehinds += -1
            awayPoints = awayPoints - 1
            awayBehindsLabel.text = String(awayBehinds)
            awayPointsLabel.text = String(awayPoints)
        }
    }
}

