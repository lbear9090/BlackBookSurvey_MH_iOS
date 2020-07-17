//
//  Surveys.h
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Surveys : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *surveyId;
@property (nonatomic, strong) NSString *organizationTypeId;
@property (nonatomic, strong) NSString *vendorId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *scoreMatrixId;
@property (nonatomic, strong) NSString *syncStatus;
@property (nonatomic, strong) NSString *surveyStatus;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *surveyTypeId;
@property (nonatomic, strong) NSString *surveyName;
@property (nonatomic, strong) NSString *isDeleted;
@property (nonatomic, strong) NSString *surveyFeedback;
@property (nonatomic, strong) NSString *roleId;
@property (nonatomic, strong) NSString *surveyScoreObtained;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
