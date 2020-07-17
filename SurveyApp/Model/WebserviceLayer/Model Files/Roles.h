//
//  Roles.h
//
//  Created by C111  on 22/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Roles : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *roleId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *roleName;
@property (nonatomic, strong) NSString *parentId;
@property (nonatomic, strong) NSString *isDeleted;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
