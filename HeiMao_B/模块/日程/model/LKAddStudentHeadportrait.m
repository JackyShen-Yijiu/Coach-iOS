//
//	LKAddStudentHeadportrait.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LKAddStudentHeadportrait.h"

NSString *const kLKAddStudentHeadportraitHeight = @"height";
NSString *const kLKAddStudentHeadportraitOriginalpic = @"originalpic";
NSString *const kLKAddStudentHeadportraitThumbnailpic = @"thumbnailpic";
NSString *const kLKAddStudentHeadportraitWidth = @"width";

@interface LKAddStudentHeadportrait ()
@end
@implementation LKAddStudentHeadportrait




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLKAddStudentHeadportraitHeight] isKindOfClass:[NSNull class]]){
		self.height = dictionary[kLKAddStudentHeadportraitHeight];
	}	
	if(![dictionary[kLKAddStudentHeadportraitOriginalpic] isKindOfClass:[NSNull class]]){
		self.originalpic = dictionary[kLKAddStudentHeadportraitOriginalpic];
	}	
	if(![dictionary[kLKAddStudentHeadportraitThumbnailpic] isKindOfClass:[NSNull class]]){
		self.thumbnailpic = dictionary[kLKAddStudentHeadportraitThumbnailpic];
	}	
	if(![dictionary[kLKAddStudentHeadportraitWidth] isKindOfClass:[NSNull class]]){
		self.width = dictionary[kLKAddStudentHeadportraitWidth];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.height != nil){
		dictionary[kLKAddStudentHeadportraitHeight] = self.height;
	}
	if(self.originalpic != nil){
		dictionary[kLKAddStudentHeadportraitOriginalpic] = self.originalpic;
	}
	if(self.thumbnailpic != nil){
		dictionary[kLKAddStudentHeadportraitThumbnailpic] = self.thumbnailpic;
	}
	if(self.width != nil){
		dictionary[kLKAddStudentHeadportraitWidth] = self.width;
	}
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
	if(self.height != nil){
		[aCoder encodeObject:self.height forKey:kLKAddStudentHeadportraitHeight];
	}
	if(self.originalpic != nil){
		[aCoder encodeObject:self.originalpic forKey:kLKAddStudentHeadportraitOriginalpic];
	}
	if(self.thumbnailpic != nil){
		[aCoder encodeObject:self.thumbnailpic forKey:kLKAddStudentHeadportraitThumbnailpic];
	}
	if(self.width != nil){
		[aCoder encodeObject:self.width forKey:kLKAddStudentHeadportraitWidth];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.height = [aDecoder decodeObjectForKey:kLKAddStudentHeadportraitHeight];
	self.originalpic = [aDecoder decodeObjectForKey:kLKAddStudentHeadportraitOriginalpic];
	self.thumbnailpic = [aDecoder decodeObjectForKey:kLKAddStudentHeadportraitThumbnailpic];
	self.width = [aDecoder decodeObjectForKey:kLKAddStudentHeadportraitWidth];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LKAddStudentHeadportrait *copy = [LKAddStudentHeadportrait new];

	copy.height = [self.height copyWithZone:zone];
	copy.originalpic = [self.originalpic copyWithZone:zone];
	copy.thumbnailpic = [self.thumbnailpic copyWithZone:zone];
	copy.width = [self.width copyWithZone:zone];

	return copy;
}
@end