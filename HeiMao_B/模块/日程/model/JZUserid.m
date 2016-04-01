//
//	JZUserid.m
//
//	Create by ytzhang on 31/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZUserid.h"

@interface JZUserid ()
@end
@implementation JZUserid




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}	
	if(![dictionary[@"headportrait"] isKindOfClass:[NSNull class]]){
		self.headportrait = [[JZHeadportrait alloc] initWithDictionary:dictionary[@"headportrait"]];
	}

	if(![dictionary[@"mobile"] isKindOfClass:[NSNull class]]){
		self.mobile = dictionary[@"mobile"];
	}	
	if(![dictionary[@"name"] isKindOfClass:[NSNull class]]){
		self.name = dictionary[@"name"];
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
		dictionary[@"_id"] = self.idField;
	}
	if(self.headportrait != nil){
		dictionary[@"headportrait"] = [self.headportrait toDictionary];
	}
	if(self.mobile != nil){
		dictionary[@"mobile"] = self.mobile;
	}
	if(self.name != nil){
		dictionary[@"name"] = self.name;
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
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:@"_id"];
	}
	if(self.headportrait != nil){
		[aCoder encodeObject:self.headportrait forKey:@"headportrait"];
	}
	if(self.mobile != nil){
		[aCoder encodeObject:self.mobile forKey:@"mobile"];
	}
	if(self.name != nil){
		[aCoder encodeObject:self.name forKey:@"name"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:@"_id"];
	self.headportrait = [aDecoder decodeObjectForKey:@"headportrait"];
	self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
	self.name = [aDecoder decodeObjectForKey:@"name"];
	return self;

}
@end