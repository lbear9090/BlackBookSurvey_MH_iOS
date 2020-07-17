//
//  Questions.h
//
//  Created by C111  on 17/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Questions : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *questionTitle;
@property (nonatomic, strong) NSString *questionFormat;
@property (nonatomic, strong) NSString *questionId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *questionDescription;
@property (nonatomic, strong) NSString *isDeleted;
@property (nonatomic, strong) NSString *questionType;
@property (nonatomic, strong) NSString *optionCount;
@property (nonatomic, strong) NSString *userAnswer;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
