//
//  User.h
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface User : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *organizationTypeId;
@property (nonatomic, strong) NSString *emailId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *lastname;
@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *firstname;
@property (nonatomic, strong) NSString *deviceType;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *isDeleted;
@property (nonatomic, strong) NSString *roleId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
