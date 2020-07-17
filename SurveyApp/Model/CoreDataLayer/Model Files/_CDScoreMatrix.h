// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDScoreMatrix.h instead.

#import <CoreData/CoreData.h>

extern const struct CDScoreMatrixAttributes {
     __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *endRange;
	 __unsafe_unretained NSString *matrixDescription;
	 __unsafe_unretained NSString *matrixTitle;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *scoreMatrixId;
	 __unsafe_unretained NSString *startRange;
} CDScoreMatrixAttributes;

@interface CDScoreMatrixID : NSManagedObjectID {}
@end

@interface _CDScoreMatrix : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDScoreMatrixID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* endRange;

//- (BOOL)validateEndRange:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* matrixDescription;

//- (BOOL)validateMatrixDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* matrixTitle;

//- (BOOL)validateMatrixTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* scoreMatrixId;

//- (BOOL)validateScoreMatrixId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* startRange;

//- (BOOL)validateStartRange:(id*)value_ error:(NSError**)error_;

@end

@interface _CDScoreMatrix (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveEndRange;
- (void)setPrimitiveEndRange:(NSString*)value;

- (NSString*)primitiveMatrixDescription;
- (void)setPrimitiveMatrixDescription:(NSString*)value;

- (NSString*)primitiveMatrixTitle;
- (void)setPrimitiveMatrixTitle:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveScoreMatrixId;
- (void)setPrimitiveScoreMatrixId:(NSString*)value;

- (NSString*)primitiveStartRange;
- (void)setPrimitiveStartRange:(NSString*)value;

@end
