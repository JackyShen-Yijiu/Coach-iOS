//
//  JENetwoking.h
//  BlackCat
//
//  Created by bestseller on 15/9/24.
//  Copyright © 2015年 lord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>



typedef NS_ENUM(NSUInteger,JENetworkingRequestMethod){
    JENetworkingRequestMethodGet,
    JENetworkingRequestMethodPost,
    JENetworkingRequestMethodPut,
    JENetworkingRequestMethodDelete
};

typedef void(^Completion)(id data);

@protocol JENetwokingDelegate <NSObject>

- (void)jeNetworkingCallBackData:(id)data;

@end

@interface JENetwoking : NSObject

//大量数据下载
+ (instancetype)initWithUrl:(NSString *)urlString WithMethod:(JENetworkingRequestMethod)method WithDelegate:(id<JENetwokingDelegate>)delegate;



//简单获取回调用于按钮点击上传图片，点击发送消息
+ (void)startDownLoadWithUrl:(NSString *)urlString
                   postParam:(id)param
                  WithMethod:(JENetworkingRequestMethod)method
              withCompletion:(Completion)completion;
@end
