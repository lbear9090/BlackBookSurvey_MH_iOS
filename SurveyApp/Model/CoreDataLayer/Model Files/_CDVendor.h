// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDVendor.h instead.

#import <CoreData/CoreData.h>

extern const struct CDVendorAttributes {
	 __unsafe_unretained NSString *categoryID;
	 __unsafe_unretained NSString *categoryName;
	 __unsafe_unretained NSString *parentCategory;
} CDVendorAttributes;

@interface CDVendorID : NSManagedObjectID {}
@end

@interface _CDVendor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDVendorID* objectID;

@property (nonatomic, retain) NSString* categoryID;

//- (BOOL)validateCategoryID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* categoryName;

//- (BOOL)validateCategoryName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* parentCategory;

//- (BOOL)validateParentCategory:(id*)value_ error:(NSError**)error_;

@end

@interface _CDVendor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategoryID;
- (void)setPrimitiveCategoryID:(NSString*)value;

- (NSString*)primitiveCategoryName;
- (void)setPrimitiveCategoryName:(NSString*)value;

- (NSString*)primitiveParentCategory;
- (void)setPrimitiveParentCategory:(NSString*)value;

@end
