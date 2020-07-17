//
//  ExpandableTableVC.h
//  SurveyApp
//
//  Created by C111 on 09/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableTableVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tblExpandable;

@end
