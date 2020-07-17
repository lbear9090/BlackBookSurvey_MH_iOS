//
//  ScoreVC.h
//  SurveyApp
//
//  Created by C111 on 30/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tblScores;

@end