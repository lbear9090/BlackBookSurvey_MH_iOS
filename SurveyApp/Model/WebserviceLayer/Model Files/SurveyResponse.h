//
//  SurveyResponse.h
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SurveyResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *surveyResponseId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *responseText;
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *isDeleted;
@property (nonatomic, strong) NSString *surveyId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
