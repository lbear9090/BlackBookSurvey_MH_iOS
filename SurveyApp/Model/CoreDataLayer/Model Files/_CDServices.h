// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDServices.h instead.

#import <CoreData/CoreData.h>

extern const struct CDServicesAttributes {
	 __unsafe_unretained NSString *categoryID;
	 __unsafe_unretained NSString *categoryName;
	 __unsafe_unretained NSString *parentCategory;
} CDServicesAttributes;

@interface CDServicesID : NSManagedObjectID {}
@end

@interface _CDServices : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDServicesID* objectID;

@property (nonatomic, retain) NSString* categoryID;

//- (BOOL)validateCategoryID:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* categoryName;

//- (BOOL)validateCategoryName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* parentCategory;

//- (BOOL)validateParentCategory:(id*)value_ error:(NSError**)error_;

@end

@interface _CDServices (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCategoryID;
- (void)setPrimitiveCategoryID:(NSString*)value;

- (NSString*)primitiveCategoryName;
- (void)setPrimitiveCategoryName:(NSString*)value;

- (NSString*)primitiveParentCategory;
- (void)setPrimitiveParentCategory:(NSString*)value;

@end
