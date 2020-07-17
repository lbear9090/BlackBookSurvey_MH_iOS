// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDVendors.h instead.

#import <CoreData/CoreData.h>

extern const struct CDVendorsAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *vendorId;
	 __unsafe_unretained NSString *vendorName;
} CDVendorsAttributes;

@interface CDVendorsID : NSManagedObjectID {}
@end

@interface _CDVendors : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDVendorsID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* vendorId;

//- (BOOL)validateVendorId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* vendorName;

//- (BOOL)validateVendorName:(id*)value_ error:(NSError**)error_;

@end

@interface _CDVendors (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveVendorId;
- (void)setPrimitiveVendorId:(NSString*)value;

- (NSString*)primitiveVendorName;
- (void)setPrimitiveVendorName:(NSString*)value;

@end
