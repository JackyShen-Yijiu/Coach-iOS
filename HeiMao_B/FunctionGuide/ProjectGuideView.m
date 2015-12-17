//
//  FunctionguideScroll.m
//  SohuCloudPics
//
//  Created by sohu on 12-11-15.
//
//

#import "ProjectGuideView.h"
#import "AppDelegate.h"

#define PAGENUM 3

static NSString * staticImage[3] = {@"guide_4_1",@"guide_4_1",@"guide_4_1"};
static NSString * staticImage6[3] ={@"guide_6_1",@"guide_6_2",@"guide_6_3"};

@implementation ProjectGuideView

+ (void)showViewWithDelegate:(id<ProjectGuideViewDelegate>)delegate
{
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    id guideView = [[ProjectGuideView alloc] initWithView:window delegate:delegate];
    [window addSubview:guideView];
}

- (id)initWithView:(UIWindow *)window delegate:(id<ProjectGuideViewDelegate>) Adelegate;
{
    self = [super init];
    if (self) {
//        if (![self shouldShowGuide]) return nil;
        delegate = Adelegate;
        self.frame = [[UIScreen mainScreen] bounds];
        _scrollView  = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
//        _scrollView.bounces = NO;
        [self addScrollviewContent];
        [self addStartButton];
//        [self addPageControll];
    }
    return self;
}
- (BOOL)isIphone5
{
    return [[UIScreen mainScreen] bounds].size.height > 480;
}
- (void)addScrollviewContent
{
    UIImageView * imageView = nil;
    CGFloat height = _scrollView.bounds.size.height;
    CGFloat offset = _scrollView.bounds.size.width;
    if (![self isIphone5]) {
        for (int i = 0; i < PAGENUM; i++) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * offset, 0, offset, height)];
            imageView.image = [UIImage imageNamed:staticImage[i]];
            imageView.tag = i;
            [_scrollView addSubview:imageView];
        }
    }else{
        for (int i = 0; i < PAGENUM; i++) {
            imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * offset, 0, offset, height)];
            imageView.image = [UIImage imageNamed:staticImage6[i]];
            imageView.tag = i;
            [_scrollView addSubview:imageView];
        }
    }
    [_scrollView setContentSize:CGSizeMake(offset * PAGENUM, height)];
}
- (void)addStartButton
{
    UIImageView * imageView = (UIImageView *)[_scrollView viewWithTag:PAGENUM - 1];
    [imageView setUserInteractionEnabled:YES];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"button_normal.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"button_press.png"] forState:UIControlStateHighlighted];
    if ([self isIphone5]) {
        button.frame = CGRectMake(80, self.frame.size.height - 80 - 44, 160, 44);
    }else{
        button.frame = CGRectMake(80, self.frame.size.height - 80 - 44, 160, 44);
    }
    button.frame = imageView.bounds;
    [button addTarget:self action:@selector(beginUseButtonClick:) forControlEvents:UIControlEventTouchDown];
    [imageView addSubview:button];
}

- (void)addPageControll
{
    _pageControll = [[SMPageControl alloc] initWithFrame:CGRectMake(110, _scrollView.bounds.size.height - 44, 100, 40)];
    _pageControll.backgroundColor = [UIColor clearColor];
    _pageControll.numberOfPages = PAGENUM;
    _pageControll.currentPage = 0;
    [_pageControll setIndicatorMargin:2];
    [_pageControll setIndicatorDiameter:5];
    [_pageControll setPageIndicatorImage:[UIImage imageNamed:@"xiaoyuanquan.png"]];
    [_pageControll setCurrentPageIndicatorImage:[UIImage imageNamed:@"xiaoyuanquan-cur.png"]];
    [_pageControll setUserInteractionEnabled:NO];
//    [self addSubview:_pageControll];
}
- (void)beginUseButtonClick:(UIButton *)button
{
//    if (button.tag != 100) {
//        if ([delegate respondsToSelector:@selector(functionGuideView:loginButtonClick:)])
//            [delegate functionGuideView:self loginButtonClick:button];
//    }
    CATransition * animation = [CATransition animation];
    animation.type = kCATransitionFade;
    animation.duration = 0.3;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    [self.superview.layer addAnimation:animation forKey:@"FadeAnimation"];
    [self removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:FUNCTIONSHOWED];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0) {
        scrollView.contentOffset = CGPointZero;
    }
    if ([scrollView isEqual:_scrollView]) {
        NSInteger curPage = floorf(([_scrollView contentOffset].x+ 161) / _scrollView.bounds.size.width);
        _pageControll.currentPage = curPage;
        if ([_scrollView contentOffset].x > _scrollView.contentSize.width - _scrollView.width ) {
            [self beginUseButtonClick:nil];
        }
    }
    NSLog(@"%f",scrollView.contentOffset.x);
}

- (BOOL)shouldShowGuide
{
    NSNumber * isShowed  = [[NSUserDefaults standardUserDefaults] objectForKey:FUNCTIONSHOWED];
    return !isShowed ||![isShowed boolValue];
}

+ (BOOL)shouldShowGuide
{
    NSNumber * isShowed  = [[NSUserDefaults standardUserDefaults] objectForKey:FUNCTIONSHOWED];
    return !isShowed ||![isShowed boolValue];
}
@end
