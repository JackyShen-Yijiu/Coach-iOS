//
//	LKAddStudentSubject.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LKAddStudentSubject.h"

NSString *const kLKAddStudentSubjectName = @"name";
NSString *const kLKAddStudentSubjectSubjectid = @"subjectid";

@interface LKAddStudentSubject ()
@end
@implementation LKAddStudentSubject




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLKAddStudentSubjectName] isKindOfClass:[NSNull class]]){
		self.name = dictionary[kLKAddStudentSubjectName];
	}	
	if(![dictionary[kLKAddStudentSubjectSubjectid] isKindOfClass:[NSNull class]]){
		self.subjectid = [dictionary[kLKAddStudentSubjectSubjectid] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.name != nil){
		dictionary[kLKAddStudentSubjectName] = self.name;
	}
	dictionary[kLKAddStudentSubjectSubjectid] = @(self.subjectid);
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:kLKAddStudentSubjectName];
	}
	[aCoder encodeObject:@(self.subjectid) forKey:kLKAddStudentSubjectSubjectid];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.name = [aDecoder decodeObjectForKey:kLKAddStudentSubjectName];
	self.subjectid = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectSubjectid] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LKAddStudentSubject *copy = [LKAddStudentSubject new];

	copy.name = [self.name copyWithZone:zone];
	copy.subjectid = self.subjectid;

	return copy;
}
@end