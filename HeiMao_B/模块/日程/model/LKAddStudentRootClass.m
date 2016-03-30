//
//	LKAddStudentRootClass.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LKAddStudentRootClass.h"

NSString *const kLKAddStudentRootClassData = @"data";
NSString *const kLKAddStudentRootClassMsg = @"msg";
NSString *const kLKAddStudentRootClassType = @"type";

@interface LKAddStudentRootClass ()
@end
@implementation LKAddStudentRootClass




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kLKAddStudentRootClassData] != nil && [dictionary[kLKAddStudentRootClassData] isKindOfClass:[NSArray class]]){
		NSArray * dataDictionaries = dictionary[kLKAddStudentRootClassData];
		NSMutableArray * dataItems = [NSMutableArray array];
		for(NSDictionary * dataDictionary in dataDictionaries){
			LKAddStudentData * dataItem = [[LKAddStudentData alloc] initWithDictionary:dataDictionary];
			[dataItems addObject:dataItem];
		}
		self.data = dataItems;
	}
	if(![dictionary[kLKAddStudentRootClassMsg] isKindOfClass:[NSNull class]]){
		self.msg = dictionary[kLKAddStudentRootClassMsg];
	}	
	if(![dictionary[kLKAddStudentRootClassType] isKindOfClass:[NSNull class]]){
		self.type = [dictionary[kLKAddStudentRootClassType] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.data != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(LKAddStudentData * dataElement in self.data){
			[dictionaryElements addObject:[dataElement toDictionary]];
		}
		dictionary[kLKAddStudentRootClassData] = dictionaryElements;
	}
	if(self.msg != nil){
		dictionary[kLKAddStudentRootClassMsg] = self.msg;
	}
	dictionary[kLKAddStudentRootClassType] = @(self.type);
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
	if(self.data != nil){
		[aCoder encodeObject:self.data forKey:kLKAddStudentRootClassData];
	}
	if(self.msg != nil){
		[aCoder encodeObject:self.msg forKey:kLKAddStudentRootClassMsg];
	}
	[aCoder encodeObject:@(self.type) forKey:kLKAddStudentRootClassType];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.data = [aDecoder decodeObjectForKey:kLKAddStudentRootClassData];
	self.msg = [aDecoder decodeObjectForKey:kLKAddStudentRootClassMsg];
	self.type = [[aDecoder decodeObjectForKey:kLKAddStudentRootClassType] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LKAddStudentRootClass *copy = [LKAddStudentRootClass new];

	copy.data = [self.data copyWithZone:zone];
	copy.msg = [self.msg copyWithZone:zone];
	copy.type = self.type;

	return copy;
}
@end