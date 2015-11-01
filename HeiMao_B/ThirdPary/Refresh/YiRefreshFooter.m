
//
//  YiRefreshFooter.m
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiRefreshFooter.h"
#import "Header.h"

@interface YiRefreshFooter (){
    

    float contentHeight;
    float scrollFrameHeight;
    float footerHeight;
    float scrollWidth;
    BOOL isAdd;
    BOOL isRefresh;
    
    
    UILabel*headerLabel;
    UIActivityIndicatorView *activityView;
    
}
@end
@implementation YiRefreshFooter

-(void)footer{

    scrollWidth=_scrollView.frame.size.width;
    footerHeight=35;
    scrollFrameHeight=_scrollView.frame.size.height;
    isAdd=NO;
    isRefresh=NO;
    
    float labelWidth=130;
    float imageWidth=13;
    float imageHeight=footerHeight;
    float labelHeight=footerHeight;
    
    self.footerView=[[UIView alloc] init];
    headerLabel=[[UILabel alloc] initWithFrame:CGRectMake((scrollWidth-labelWidth)/2, 0, labelWidth, labelHeight)];
    [self.self.footerView addSubview:headerLabel];
    headerLabel.textAlignment=NSTextAlignmentCenter;
    headerLabel.text=@"加载更多...";
    headerLabel.font=[UIFont systemFontOfSize:14];
    
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame=CGRectMake(headerLabel.right - 5, 0, imageWidth, imageHeight);
    [self.footerView addSubview:activityView];
    
    activityView.hidden=YES;
 
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [_scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

 
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
   
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self.footerView setHidden:_scrollView.contentSize.height <= _scrollView.height];
        return;
    }
    
    if (![@"contentOffset" isEqualToString:keyPath]) return;
     contentHeight=_scrollView.contentSize.height;

    
    if (!isAdd) {
        isAdd=YES;
        
        self.footerView.frame=CGRectMake(0, contentHeight, scrollWidth, footerHeight);
        [_scrollView addSubview:self.footerView];
    }
    
    self.footerView.frame=CGRectMake(0, contentHeight, scrollWidth, footerHeight);
//    activityView.frame=CGRectMake((scrollWidth-footerHeight)/2, 0, footerHeight, footerHeight);

    int currentPostion = _scrollView.contentOffset.y;
    
   
//   进入刷新状态
    if ((currentPostion>(contentHeight-scrollFrameHeight))&&(contentHeight>scrollFrameHeight) && !self.footerView.isHidden) {
        
        [self beginRefreshing];
    }
    
}
//开始刷新操作  如果正在刷新则不做操作
-(void)beginRefreshing{
    if (!isRefresh) {
        isRefresh= YES;
        [activityView startAnimating];
        //        设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.contentInset=UIEdgeInsetsMake(0, _scrollView.contentInset.left,  footerHeight, _scrollView.contentInset.left);
   
        }];
        
        //        block回调
        _beginRefreshingBlock();
    }

}
//关闭刷新操作
-(void)endRefreshing{
     isRefresh=NO;
    
  
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            [activityView stopAnimating];
            
            _scrollView.contentInset = UIEdgeInsetsMake(0 ,_scrollView.contentInset.left, 0, _scrollView.contentInset.right);
            self.footerView.frame=CGRectMake(0, contentHeight, WScreen, footerHeight);
        }];
    });
}

-(void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [_scrollView removeObserver:self forKeyPath:@"contentSize"];
}

@end
