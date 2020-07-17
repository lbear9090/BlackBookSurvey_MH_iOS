// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDRoles.h instead.

#import <CoreData/CoreData.h>

extern const struct CDRolesAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *level;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *parentId;
	 __unsafe_unretained NSString *roleId;
	 __unsafe_unretained NSString *roleName;
} CDRolesAttributes;

@interface CDRolesID : NSManagedObjectID {}
@end

@interface _CDRoles : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDRolesID* objectID;

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

@property (nonatomic, retain) NSString* roleId;

//- (BOOL)validateRoleId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* roleName;

//- (BOOL)validateRoleName:(id*)value_ error:(NSError**)error_;

@end

@interface _CDRoles (CoreDataGeneratedPrimitiveAccessors)

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

- (NSString*)primitiveRoleId;
- (void)setPrimitiveRoleId:(NSString*)value;

- (NSString*)primitiveRoleName;
- (void)setPrimitiveRoleName:(NSString*)value;

@end
