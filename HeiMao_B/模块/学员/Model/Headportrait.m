//
//	Headportrait.m
//
//	Create by ytzhang on 29/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Headportrait.h"

@interface Headportrait ()
@end
@implementation Headportrait




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"height"] isKindOfClass:[NSNull class]]){
		self.height = dictionary[@"height"];
	}	
	if(![dictionary[@"originalpic"] isKindOfClass:[NSNull class]]){
		self.originalpic = dictionary[@"originalpic"];
	}	
	if(![dictionary[@"thumbnailpic"] isKindOfClass:[NSNull class]]){
		self.thumbnailpic = dictionary[@"thumbnailpic"];
	}	
	if(![dictionary[@"width"] isKindOfClass:[NSNull class]]){
		self.width = dictionary[@"width"];
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
		dictionary[@"height"] = self.height;
	}
	if(self.originalpic != nil){
		dictionary[@"originalpic"] = self.originalpic;
	}
	if(self.thumbnailpic != nil){
		dictionary[@"thumbnailpic"] = self.thumbnailpic;
	}
	if(self.width != nil){
		dictionary[@"width"] = self.width;
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
		[aCoder encodeObject:self.height forKey:@"height"];
	}
	if(self.originalpic != nil){
		[aCoder encodeObject:self.originalpic forKey:@"originalpic"];
	}
	if(self.thumbnailpic != nil){
		[aCoder encodeObject:self.thumbnailpic forKey:@"thumbnailpic"];
	}
	if(self.width != nil){
		[aCoder encodeObject:self.width forKey:@"width"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.height = [aDecoder decodeObjectForKey:@"height"];
	self.originalpic = [aDecoder decodeObjectForKey:@"originalpic"];
	self.thumbnailpic = [aDecoder decodeObjectForKey:@"thumbnailpic"];
	self.width = [aDecoder decodeObjectForKey:@"width"];
	return self;

}
@end