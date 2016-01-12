//
//  HMStudentModel.m
//  HeiMao_B
//
//  Created by kequ on 15/10/25.
//  Copyright © 2015年 ke. All rights reserved.
//

#import "HMStudentModel.h"

@implementation HMStudentModel
+ (HMStudentModel *)converJsonDicToModel:(NSDictionary *)dic
{
    
//    HMStudentModel * model = [[HMStudentModel alloc] init];
//    model.userName = @"王星宇";
//    model.porInfo = [HMPortraitInfoModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];
//    model.userId = @"2323423434";
//    model.schoolInfo = [HMSchoolInfoModel converJsonDicToModel:nil];
//    model.carLicenseType = @"C1本";
//    model.courseSchedule = @"科目二第16学时";
//    model.commmonAddress = @"北京市昌平区天通苑";
    
    if (!dic || ![dic isKindOfClass:[NSDictionary class]] ||![dic allKeys].count) {
        return nil;
    }
    HMStudentModel * model = [[HMStudentModel alloc] init];
    model.userId = [dic objectStringForKey:@"_id"];
    model.disPlayId = [dic objectStringForKey:@"displayuserid"];
    model.userName = [dic objectStringForKey:@"name"];
    model.porInfo = [HMPortraitInfoModel converJsonDicToModel:[dic objectInfoForKey:@"headportrait"]];
    model.schoolInfo = [HMSchoolInfoModel converJsonDicToModel:[dic objectInfoForKey:@"applyschoolinfo"]];
    model.carLicenseInfo = [HMCarLicenseModel converJsonDicToModel:[dic objectInfoForKey:@"carmodel"]];
    model.courseSchedule = [dic objectStringForKey:@"subjectprocess"];
    model.telPhoto = [dic objectStringForKey:@"mobile"];
    model.commmonAddress = [dic objectStringForKey:@"address"];
    model.subjectInfo = [HMSubjectModel converJsonDicToModel:[dic objectInfoForKey:@"subject"]];
    model.leavecoursecount = [[dic objectForKey:@"leavecoursecount"] intValue];
    model.missingcoursecount = [[dic objectForKey:@"missingcoursecount"] intValue];
    
    return model;
}
@end
