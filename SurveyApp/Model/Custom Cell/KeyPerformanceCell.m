//
//  KeyPerformanceCell.m
//  SurveyApp
//
//  Created by C111 on 18/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import "KeyPerformanceCell.h"

@implementation KeyPerformanceCell

@synthesize lblKeyPerformanceIndicator, lblPoints;

- (void)awakeFromNib
{

}

- (id)initWithStyleForKeyPerformanceIndicator:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        lblKeyPerformanceIndicator = [[UILabel alloc] initWithFrame:CGRectMake(8.0 , 0.0, SCREEN_WIDTH - 50.0, 46.0)];
        lblKeyPerformanceIndicator.font = SFUITextRegular(15.0);
        lblKeyPerformanceIndicator.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lblKeyPerformanceIndicator];
        
        lblPoints = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lblKeyPerformanceIndicator.frame) + 8.0, 0.0, 30.0, 30.0)];
        lblPoints.font = SFUITextRegular(15.0);
        lblPoints.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lblPoints];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end