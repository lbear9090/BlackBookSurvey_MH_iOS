//
//  SurveyType.h
//
//  Created by C111  on 22/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SurveyType : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *surveyTypeId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *surveyTypeName;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *isDeleted;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
