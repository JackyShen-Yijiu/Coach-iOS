//
//	LKAddStudentSubjectthree.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LKAddStudentSubjectthree.h"

NSString *const kLKAddStudentSubjectthreeBuycoursecount = @"buycoursecount";
NSString *const kLKAddStudentSubjectthreeFinishcourse = @"finishcourse";
NSString *const kLKAddStudentSubjectthreeMissingcourse = @"missingcourse";
NSString *const kLKAddStudentSubjectthreeOfficialfinishhours = @"officialfinishhours";
NSString *const kLKAddStudentSubjectthreeOfficialhours = @"officialhours";
NSString *const kLKAddStudentSubjectthreeProgress = @"progress";
NSString *const kLKAddStudentSubjectthreeReservation = @"reservation";
NSString *const kLKAddStudentSubjectthreeReservationid = @"reservationid";
NSString *const kLKAddStudentSubjectthreeTotalcourse = @"totalcourse";

@interface LKAddStudentSubjectthree ()
@end
@implementation LKAddStudentSubjectthree




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLKAddStudentSubjectthreeBuycoursecount] isKindOfClass:[NSNull class]]){
		self.buycoursecount = [dictionary[kLKAddStudentSubjectthreeBuycoursecount] integerValue];
	}

	if(![dictionary[kLKAddStudentSubjectthreeFinishcourse] isKindOfClass:[NSNull class]]){
		self.finishcourse = [dictionary[kLKAddStudentSubjectthreeFinishcourse] integerValue];
	}

	if(![dictionary[kLKAddStudentSubjectthreeMissingcourse] isKindOfClass:[NSNull class]]){
		self.missingcourse = [dictionary[kLKAddStudentSubjectthreeMissingcourse] integerValue];
	}

	if(![dictionary[kLKAddStudentSubjectthreeOfficialfinishhours] isKindOfClass:[NSNull class]]){
		self.officialfinishhours = [dictionary[kLKAddStudentSubjectthreeOfficialfinishhours] integerValue];
	}

	if(![dictionary[kLKAddStudentSubjectthreeOfficialhours] isKindOfClass:[NSNull class]]){
		self.officialhours = [dictionary[kLKAddStudentSubjectthreeOfficialhours] integerValue];
	}

	if(![dictionary[kLKAddStudentSubjectthreeProgress] isKindOfClass:[NSNull class]]){
		self.progress = dictionary[kLKAddStudentSubjectthreeProgress];
	}	
	if(![dictionary[kLKAddStudentSubjectthreeReservation] isKindOfClass:[NSNull class]]){
		self.reservation = [dictionary[kLKAddStudentSubjectthreeReservation] integerValue];
	}

	if(![dictionary[kLKAddStudentSubjectthreeReservationid] isKindOfClass:[NSNull class]]){
		self.reservationid = dictionary[kLKAddStudentSubjectthreeReservationid];
	}	
	if(![dictionary[kLKAddStudentSubjectthreeTotalcourse] isKindOfClass:[NSNull class]]){
		self.totalcourse = [dictionary[kLKAddStudentSubjectthreeTotalcourse] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kLKAddStudentSubjectthreeBuycoursecount] = @(self.buycoursecount);
	dictionary[kLKAddStudentSubjectthreeFinishcourse] = @(self.finishcourse);
	dictionary[kLKAddStudentSubjectthreeMissingcourse] = @(self.missingcourse);
	dictionary[kLKAddStudentSubjectthreeOfficialfinishhours] = @(self.officialfinishhours);
	dictionary[kLKAddStudentSubjectthreeOfficialhours] = @(self.officialhours);
	if(self.progress != nil){
		dictionary[kLKAddStudentSubjectthreeProgress] = self.progress;
	}
	dictionary[kLKAddStudentSubjectthreeReservation] = @(self.reservation);
	if(self.reservationid != nil){
		dictionary[kLKAddStudentSubjectthreeReservationid] = self.reservationid;
	}
	dictionary[kLKAddStudentSubjectthreeTotalcourse] = @(self.totalcourse);
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
	[aCoder encodeObject:@(self.buycoursecount) forKey:kLKAddStudentSubjectthreeBuycoursecount];	[aCoder encodeObject:@(self.finishcourse) forKey:kLKAddStudentSubjectthreeFinishcourse];	[aCoder encodeObject:@(self.missingcourse) forKey:kLKAddStudentSubjectthreeMissingcourse];	[aCoder encodeObject:@(self.officialfinishhours) forKey:kLKAddStudentSubjectthreeOfficialfinishhours];	[aCoder encodeObject:@(self.officialhours) forKey:kLKAddStudentSubjectthreeOfficialhours];	if(self.progress != nil){
		[aCoder encodeObject:self.progress forKey:kLKAddStudentSubjectthreeProgress];
	}
	[aCoder encodeObject:@(self.reservation) forKey:kLKAddStudentSubjectthreeReservation];	if(self.reservationid != nil){
		[aCoder encodeObject:self.reservationid forKey:kLKAddStudentSubjectthreeReservationid];
	}
	[aCoder encodeObject:@(self.totalcourse) forKey:kLKAddStudentSubjectthreeTotalcourse];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.buycoursecount = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeBuycoursecount] integerValue];
	self.finishcourse = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeFinishcourse] integerValue];
	self.missingcourse = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeMissingcourse] integerValue];
	self.officialfinishhours = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeOfficialfinishhours] integerValue];
	self.officialhours = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeOfficialhours] integerValue];
	self.progress = [aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeProgress];
	self.reservation = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeReservation] integerValue];
	self.reservationid = [aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeReservationid];
	self.totalcourse = [[aDecoder decodeObjectForKey:kLKAddStudentSubjectthreeTotalcourse] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LKAddStudentSubjectthree *copy = [LKAddStudentSubjectthree new];

	copy.buycoursecount = self.buycoursecount;
	copy.finishcourse = self.finishcourse;
	copy.missingcourse = self.missingcourse;
	copy.officialfinishhours = self.officialfinishhours;
	copy.officialhours = self.officialhours;
	copy.progress = [self.progress copyWithZone:zone];
	copy.reservation = self.reservation;
	copy.reservationid = [self.reservationid copyWithZone:zone];
	copy.totalcourse = self.totalcourse;

	return copy;
}
@end