// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDRating.h instead.

#import <CoreData/CoreData.h>

extern const struct CDRatingAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *level;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *parentId;
	 __unsafe_unretained NSString *ratingId;
	 __unsafe_unretained NSString *ratingName;
} CDRatingAttributes;

@interface CDRatingID : NSManagedObjectID {}
@end

@interface _CDRating : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDRatingID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* level;

//- (BOOL)validateLevel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* parentId;

//- (BOOL)validateParentId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* ratingId;

//- (BOOL)validateRatingId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* ratingName;

//- (BOOL)validateRatingName:(id*)value_ error:(NSError**)error_;

@end

@interface _CDRating (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveLevel;
- (void)setPrimitiveLevel:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveParentId;
- (void)setPrimitiveParentId:(NSString*)value;

- (NSString*)primitiveRatingId;
- (void)setPrimitiveRatingId:(NSString*)value;

- (NSString*)primitiveRatingName;
- (void)setPrimitiveRatingName:(NSString*)value;

@end
