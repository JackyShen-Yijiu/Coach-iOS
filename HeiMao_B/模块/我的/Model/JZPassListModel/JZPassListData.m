//
//	JZPassListData.m
//
//	Create by ytzhang on 1/4/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZPassListData.h"

@interface JZPassListData ()
@end
@implementation JZPassListData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}	
	if(![dictionary[@"examinationdate"] isKindOfClass:[NSNull class]]){
		self.examinationdate = dictionary[@"examinationdate"];
	}	
	if(![dictionary[@"examinationstate"] isKindOfClass:[NSNull class]]){
		self.examinationstate = [dictionary[@"examinationstate"] integerValue];
	}

	if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
		self.userid = [[JZPassListUserid alloc] initWithDictionary:dictionary[@"userid"]];
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
	if(self.examinationdate != nil){
		dictionary[@"examinationdate"] = self.examinationdate;
	}
	dictionary[@"examinationstate"] = @(self.examinationstate);
	if(self.userid != nil){
		dictionary[@"userid"] = [self.userid toDictionary];
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
	if(self.examinationdate != nil){
		[aCoder encodeObject:self.examinationdate forKey:@"examinationdate"];
	}
	[aCoder encodeObject:@(self.examinationstate) forKey:@"examinationstate"];	if(self.userid != nil){
		[aCoder encodeObject:self.userid forKey:@"userid"];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.idField = [aDecoder decodeObjectForKey:@"_id"];
	self.examinationdate = [aDecoder decodeObjectForKey:@"examinationdate"];
	self.examinationstate = [[aDecoder decodeObjectForKey:@"examinationstate"] integerValue];
	self.userid = [aDecoder decodeObjectForKey:@"userid"];
	return self;

}
@end