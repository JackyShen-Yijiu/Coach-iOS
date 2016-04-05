//
//	Applyclasstypeinfo.m
//
//	Create by ytzhang on 29/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Applyclasstypeinfo.h"

@interface Applyclasstypeinfo ()
@end
@implementation Applyclasstypeinfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"id"];
	}	
	if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
		self.name = dictionary[@"name"];
	}	
	if(![dictionary[@"onsaleprice"] isKindOfClass:[NSNull class]]){
		self.onsaleprice = [dictionary[@"onsaleprice"] integerValue];
	}

	if(![dictionary[@"price"] isKindOfClass:[NSNull class]]){
		self.price = [dictionary[@"price"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.idField != nil){
		dictionary[@"id"] = self.idField;
	}
	if(self.name != nil){
		dictionary[@"name"] = self.name;
	}
	dictionary[@"onsaleprice"] = @(self.onsaleprice);
	dictionary[@"price"] = @(self.price);
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
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:@"id"];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:@"name"];
	}
	[aCoder encodeObject:@(self.onsaleprice) forKey:@"onsaleprice"];	[aCoder encodeObject:@(self.price) forKey:@"price"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:@"id"];
	self.name = [aDecoder decodeObjectForKey:@"name"];
	self.onsaleprice = [[aDecoder decodeObjectForKey:@"onsaleprice"] integerValue];
	self.price = [[aDecoder decodeObjectForKey:@"price"] integerValue];
	return self;

}
@end