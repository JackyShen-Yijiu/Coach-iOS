//
//	JZData.m
//
//	Create by ytzhang on 31/3/2016
//	Copyright © 2016. All rights reserved.
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "JZData.h"

@interface JZData ()
@end
@implementation JZData




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[@"_id"] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[@"_id"];
	}	
	if(![dictionary[@"begintime"] isKindOfClass:[NSNull class]]){
		self.begintime = dictionary[@"begintime"];
	}	
	if(![dictionary[@"endtime"] isKindOfClass:[NSNull class]]){
		self.endtime = dictionary[@"endtime"];
	}	
	if(![dictionary[@"reservationcreatetime"] isKindOfClass:[NSNull class]]){
		self.reservationcreatetime = dictionary[@"reservationcreatetime"];
	}	
	if(![dictionary[@"reservationstate"] isKindOfClass:[NSNull class]]){
		self.reservationstate = dictionary[@"reservationstate"];
	}	
	if(![dictionary[@"subject"] isKindOfClass:[NSNull class]]){
		self.subject = [[JZSubject alloc] initWithDictionary:dictionary[@"subject"]];
	}

	if(![dictionary[@"userid"] isKindOfClass:[NSNull class]]){
		self.userid = [[JZUserid alloc] initWithDictionary:dictionary[@"userid"]];
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
	if(self.begintime != nil){
		dictionary[@"begintime"] = self.begintime;
	}
	if(self.endtime != nil){
		dictionary[@"endtime"] = self.endtime;
	}
	if(self.reservationcreatetime != nil){
		dictionary[@"reservationcreatetime"] = self.reservationcreatetime;
	}
	if(self.reservationstate != nil){
		dictionary[@"reservationstate"] = self.reservationstate;
	}
	if(self.subject != nil){
		dictionary[@"subject"] = [self.subject toDictionary];
	}
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
	if(self.begintime != nil){
		[aCoder encodeObject:self.begintime forKey:@"begintime"];
	}
	if(self.endtime != nil){
		[aCoder encodeObject:self.endtime forKey:@"endtime"];
	}
	if(self.reservationcreatetime != nil){
		[aCoder encodeObject:self.reservationcreatetime forKey:@"reservationcreatetime"];
	}
	if(self.reservationstate != nil){
		[aCoder encodeObject:self.reservationstate forKey:@"reservationstate"];
	}
	if(self.subject != nil){
		[aCoder encodeObject:self.subject forKey:@"subject"];
	}
	if(self.userid != nil){
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
	self.begintime = [aDecoder decodeObjectForKey:@"begintime"];
	self.endtime = [aDecoder decodeObjectForKey:@"endtime"];
	self.reservationcreatetime = [aDecoder decodeObjectForKey:@"reservationcreatetime"];
	self.reservationstate = [aDecoder decodeObjectForKey:@"reservationstate"];
	self.subject = [aDecoder decodeObjectForKey:@"subject"];
	self.userid = [aDecoder decodeObjectForKey:@"userid"];
	return self;

}
@end