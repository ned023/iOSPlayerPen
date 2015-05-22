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

    @IBOutlet weak var awayGoalsLabel: UILabel!
    @IBOutlet weak var awayBehindsLabel: UILabel!
    @IBOutlet weak var awayPointsLabel: UILabel!
    
    
    var homeGoals = 0
    var homeBehinds = 0
    var homePoints = 0
    var awayGoals = 0
    var awayBehinds = 0
    var awayPoints = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

