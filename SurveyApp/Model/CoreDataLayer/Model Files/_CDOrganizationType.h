// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDOrganizationType.h instead.

#import <CoreData/CoreData.h>

extern const struct CDOrganizationTypeAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *isOptional;
	 __unsafe_unretained NSString *level;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *organizationTypeId;
	 __unsafe_unretained NSString *organizationTypeName;
	 __unsafe_unretained NSString *parentId;
} CDOrganizationTypeAttributes;

@interface CDOrganizationTypeID : NSManagedObjectID {}
@end

@interface _CDOrganizationType : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDOrganizationTypeID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* isOptional;

//- (BOOL)validateIsOptional:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* level;

//- (BOOL)validateLevel:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* organizationTypeId;

//- (BOOL)validateOrganizationTypeId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* organizationTypeName;

//- (BOOL)validateOrganizationTypeName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* parentId;

//- (BOOL)validateParentId:(id*)value_ error:(NSError**)error_;

@end

@interface _CDOrganizationType (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveIsOptional;
- (void)setPrimitiveIsOptional:(NSString*)value;

- (NSString*)primitiveLevel;
- (void)setPrimitiveLevel:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveOrganizationTypeId;
- (void)setPrimitiveOrganizationTypeId:(NSString*)value;

- (NSString*)primitiveOrganizationTypeName;
- (void)setPrimitiveOrganizationTypeName:(NSString*)value;

- (NSString*)primitiveParentId;
- (void)setPrimitiveParentId:(NSString*)value;

@end
