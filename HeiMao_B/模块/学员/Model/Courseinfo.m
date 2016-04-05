//
//	Courseinfo.m
//
//	Create by ytzhang on 29/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "Courseinfo.h"

@interface Courseinfo ()
@end
@implementation Courseinfo




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"buycoursecount"] isKindOfClass:[NSNull class]]){
		self.buycoursecount = [dictionary[@"buycoursecount"] integerValue];
	}

	if(![dictionary[@"finishcourse"] isKindOfClass:[NSNull class]]){
		self.finishcourse = [dictionary[@"finishcourse"] integerValue];
	}

	if(![dictionary[@"missingcourse"] isKindOfClass:[NSNull class]]){
		self.missingcourse = [dictionary[@"missingcourse"] integerValue];
	}

	if(![dictionary[@"officialfinishhours"] isKindOfClass:[NSNull class]]){
		self.officialfinishhours = [dictionary[@"officialfinishhours"] integerValue];
	}

	if(![dictionary[@"officialhours"] isKindOfClass:[NSNull class]]){
		self.officialhours = [dictionary[@"officialhours"] integerValue];
	}

	if(![dictionary[@"progress"] isKindOfClass:[NSNull class]]){
		self.progress = dictionary[@"progress"];
	}	
	if(![dictionary[@"reservation"] isKindOfClass:[NSNull class]]){
		self.reservation = [dictionary[@"reservation"] integerValue];
	}

	if(![dictionary[@"totalcourse"] isKindOfClass:[NSNull class]]){
		self.totalcourse = [dictionary[@"totalcourse"] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[@"buycoursecount"] = @(self.buycoursecount);
	dictionary[@"finishcourse"] = @(self.finishcourse);
	dictionary[@"missingcourse"] = @(self.missingcourse);
	dictionary[@"officialfinishhours"] = @(self.officialfinishhours);
	dictionary[@"officialhours"] = @(self.officialhours);
	if(self.progress != nil){
		dictionary[@"progress"] = self.progress;
	}
	dictionary[@"reservation"] = @(self.reservation);
	dictionary[@"totalcourse"] = @(self.totalcourse);
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
	[aCoder encodeObject:@(self.buycoursecount) forKey:@"buycoursecount"];	[aCoder encodeObject:@(self.finishcourse) forKey:@"finishcourse"];	[aCoder encodeObject:@(self.missingcourse) forKey:@"missingcourse"];	[aCoder encodeObject:@(self.officialfinishhours) forKey:@"officialfinishhours"];	[aCoder encodeObject:@(self.officialhours) forKey:@"officialhours"];	if(self.progress != nil){
		[aCoder encodeObject:self.progress forKey:@"progress"];
	}
	[aCoder encodeObject:@(self.reservation) forKey:@"reservation"];	[aCoder encodeObject:@(self.totalcourse) forKey:@"totalcourse"];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.buycoursecount = [[aDecoder decodeObjectForKey:@"buycoursecount"] integerValue];
	self.finishcourse = [[aDecoder decodeObjectForKey:@"finishcourse"] integerValue];
	self.missingcourse = [[aDecoder decodeObjectForKey:@"missingcourse"] integerValue];
	self.officialfinishhours = [[aDecoder decodeObjectForKey:@"officialfinishhours"] integerValue];
	self.officialhours = [[aDecoder decodeObjectForKey:@"officialhours"] integerValue];
	self.progress = [aDecoder decodeObjectForKey:@"progress"];
	self.reservation = [[aDecoder decodeObjectForKey:@"reservation"] integerValue];
	self.totalcourse = [[aDecoder decodeObjectForKey:@"totalcourse"] integerValue];
	return self;

}
@end