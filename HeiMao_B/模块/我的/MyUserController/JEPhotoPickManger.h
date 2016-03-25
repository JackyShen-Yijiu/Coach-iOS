//
//  JEPhotoPickManger.h
//  BlackCat
//
//  Created by bestseller on 15/9/18.
//  Copyright (c) 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JEPhotoPickManger : NSObject
+ (void)pickPhotofromController:(UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>*)fromController;
@end
