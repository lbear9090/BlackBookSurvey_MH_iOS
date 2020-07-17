//
//  KeyPerformanceCell.h
//  SurveyApp
//
//  Created by C111 on 18/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyPerformanceCell : UITableViewCell

- (id)initWithStyleForKeyPerformanceIndicator:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (strong, nonatomic) IBOutlet UILabel *lblKeyPerformanceIndicator;
@property (strong, nonatomic) IBOutlet UILabel *lblPoints;

@end