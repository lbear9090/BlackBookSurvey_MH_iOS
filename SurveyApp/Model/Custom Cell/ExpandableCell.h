//
//  ExpandableCell.h
//  SurveyApp
//
//  Created by C111 on 22/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UIView *viewSeperator;

@end