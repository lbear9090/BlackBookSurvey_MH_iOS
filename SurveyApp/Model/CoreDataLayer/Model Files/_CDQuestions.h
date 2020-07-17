// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CDQuestions.h instead.

#import <CoreData/CoreData.h>

extern const struct CDQuestionsAttributes {
	 __unsafe_unretained NSString *createdDate;
	 __unsafe_unretained NSString *deleted;
	 __unsafe_unretained NSString *modifiedDate;
	 __unsafe_unretained NSString *optionCount;
	 __unsafe_unretained NSString *questionDescription;
	 __unsafe_unretained NSString *questionFormat;
	 __unsafe_unretained NSString *questionId;
	 __unsafe_unretained NSString *questionTitle;
	 __unsafe_unretained NSString *questionType;
	 __unsafe_unretained NSString *userResponse;
} CDQuestionsAttributes;

@interface CDQuestionsID : NSManagedObjectID {}
@end

@interface _CDQuestions : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CDQuestionsID* objectID;

@property (nonatomic, retain) NSString* createdDate;

//- (BOOL)validateCreatedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* deleted;

//- (BOOL)validateDeleted:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* modifiedDate;

//- (BOOL)validateModifiedDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* optionCount;

//- (BOOL)validateOptionCount:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* questionDescription;

//- (BOOL)validateQuestionDescription:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* questionFormat;

//- (BOOL)validateQuestionFormat:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* questionId;

//- (BOOL)validateQuestionId:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* questionTitle;

//- (BOOL)validateQuestionTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* questionType;

//- (BOOL)validateQuestionType:(id*)value_ error:(NSError**)error_;

@property (nonatomic, retain) NSString* userResponse;

//- (BOOL)validateUserResponse:(id*)value_ error:(NSError**)error_;

@end

@interface _CDQuestions (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveCreatedDate;
- (void)setPrimitiveCreatedDate:(NSString*)value;

- (NSString*)primitiveDeleted;
- (void)setPrimitiveDeleted:(NSString*)value;

- (NSString*)primitiveModifiedDate;
- (void)setPrimitiveModifiedDate:(NSString*)value;

- (NSString*)primitiveOptionCount;
- (void)setPrimitiveOptionCount:(NSString*)value;

- (NSString*)primitiveQuestionDescription;
- (void)setPrimitiveQuestionDescription:(NSString*)value;

- (NSString*)primitiveQuestionFormat;
- (void)setPrimitiveQuestionFormat:(NSString*)value;

- (NSString*)primitiveQuestionId;
- (void)setPrimitiveQuestionId:(NSString*)value;

- (NSString*)primitiveQuestionTitle;
- (void)setPrimitiveQuestionTitle:(NSString*)value;

- (NSString*)primitiveQuestionType;
- (void)setPrimitiveQuestionType:(NSString*)value;

- (NSString*)primitiveUserResponse;
- (void)setPrimitiveUserResponse:(NSString*)value;

@end
