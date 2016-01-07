//
//  ShopMainModel.h
//  Magic
//
//  Created by ytzhang on 15/11/11.
//  Copyright © 2015年 ytzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopMainModel : NSObject
@property (nonatomic,strong) NSString *productid;
@property (nonatomic,strong) NSString *productname;
@property (nonatomic,assign) int  productprice;
@property (nonatomic,strong) NSString *productimg;
@property (nonatomic,strong) NSString *productdesc;
@property (nonatomic,assign) int  viewcount;
@property (nonatomic,assign) int  buycount;
@property (nonatomic,strong) NSString *detailsimg;
@end
