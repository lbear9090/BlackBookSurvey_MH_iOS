//
//  Vendors.h
//
//  Created by C111  on 16/03/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Vendors : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *createdDate;
@property (nonatomic, strong) NSString *vendorId;
@property (nonatomic, strong) NSString *vendorName;
@property (nonatomic, strong) NSString *modifiedDate;
@property (nonatomic, strong) NSString *isDeleted;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
