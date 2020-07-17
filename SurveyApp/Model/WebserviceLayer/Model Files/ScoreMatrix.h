//
//  ScoreMatrix.h
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ScoreMatrix : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *scoreMatrixId;
@property (nonatomic, strong) NSString *matrixTitle;
@property (nonatomic, strong) NSString *startRange;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *isDeleted;
@property (nonatomic, strong) NSString *matrixDescription;
@property (nonatomic, strong) NSString *endRange;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
