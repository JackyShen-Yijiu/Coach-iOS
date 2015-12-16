//
//  FunctionguideScroll.h
//  SohuCloudPics
//
//  Created by sohu on 12-11-15.
//
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"


#define FUNCTIONSHOWED [NSString stringWithFormat:@"__FUNCTIONSHOWED__%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]

@class ProjectGuideView;
@protocol ProjectGuideViewDelegate <NSObject>
@optional
- (void)functionGuideView:(ProjectGuideView *)guideView loginButtonClick:(UIButton *)button;
@end
@interface ProjectGuideView : UIView <UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    SMPageControl * _pageControll;
    id<ProjectGuideViewDelegate> delegate;
}
+ (void)showViewWithDelegate:(id<ProjectGuideViewDelegate>)delegate;
+ (BOOL)shouldShowGuide;
@end
