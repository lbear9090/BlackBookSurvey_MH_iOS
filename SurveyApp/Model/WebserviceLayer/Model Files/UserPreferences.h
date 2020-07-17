//
//  UserPreferences.h
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserPreferences : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *userPreferenceId;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *isDeleted;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *preferenceId;
@property (nonatomic, strong) NSString *preference;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
