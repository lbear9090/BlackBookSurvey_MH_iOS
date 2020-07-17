// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDPreferences.h instead.

#import <CoreData/CoreData.h>

extern const struct CDPreferencesAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *preferenceId;
	 __unsafe_unretained NSString *preferenceText;
} CDPreferencesAttributes;

@interface CDPreferencesID : NSManagedObjectID {}
@end

@interface _CDPreferences : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDPreferencesID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* preferenceId;

//- (BOOL)validatePreferenceId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* preferenceText;

//- (BOOL)validatePreferenceText:(id*)value_ error:(NSError**)error_;

@end

@interface _CDPreferences (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitivePreferenceId;
- (void)setPrimitivePreferenceId:(NSString*)value;

- (NSString*)primitivePreferenceText;
- (void)setPrimitivePreferenceText:(NSString*)value;

@end
