//
//  Country.h
//  SurveyApp
//
//  Created by C111 on 23/03/16.
//  Copyright © 2016 C111. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, assign) int countryId;
@property (nonatomic, retain) NSString * countryISO2;
@property (nonatomic, retain) NSString * countryShortName;
@property (nonatomic, retain) NSString * countryFullName;
@property (nonatomic, retain) NSString * countryISO3;
@property (nonatomic, retain) NSString * countryCallingCode;

@end
