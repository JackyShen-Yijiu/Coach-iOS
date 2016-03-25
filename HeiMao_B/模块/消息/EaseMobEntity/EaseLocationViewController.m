//
//  EaseLocationViewController.m
//  ChatDemo-UI3.0
//
//  Created by dhc on 2/7/24.
//  Copyright (c) 2015年 easemob.com. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "EaseLocationViewController.h"

#import "UIViewController+HUD.h"

static EaseLocationViewController *defaultLocation = nil;

@interface EaseLocationViewController () <MKMapViewDelegate,CLLocationManagerDelegate>
{
    MKMapView *_mapView;
    MKPointAnnotation *_annotation;
    CLLocationManager *_locationManager;
    CLLocationCoordinate2D _currentLocationCoordinate;
    BOOL _isSendLocation;
}

@property (strong, nonatomic) NSString *addressString;
@property (nonatomic,strong) UIButton * sendButton;
@end

@implementation EaseLocationViewController

@synthesize addressString = _addressString;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _isSendLocation = YES;
    }
    
    return self;
}

- (instancetype)initWithLocation:(CLLocationCoordinate2D)locationCoordinate
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _isSendLocation = NO;
        _currentLocationCoordinate = locationCoordinate;
    }
    
    return self;
}

+ (instancetype)defaultLocation
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultLocation = [[EaseLocationViewController alloc] initWithNibName:nil bundle:nil];
    });
    
    return defaultLocation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myNavigationItem.title = NSLocalizedString(@"location.messageType", @"location message");
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.zoomEnabled = YES;
    [self.view addSubview:_mapView];
    
    if (_isSendLocation) {
        _mapView.showsUserLocation = YES;//显示当前位置
        
        self.sendButton = [self getBarButtonWithTitle:@"发送"];
        [self.sendButton addTarget:self action:@selector(sendLocation) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:self.sendButton];
        self.myNavigationItem.rightBarButtonItems = @[[self barSpaingItem],item];
        [self.sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.sendButton setUserInteractionEnabled:NO];
        [self startLocation];
    }
    else{
        [self removeToLocation:_currentLocationCoordinate];
    }
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    __weak typeof(self) weakSelf = self;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (!error && array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            weakSelf.addressString = placemark.name;
            
            [self removeToLocation:userLocation.coordinate];
        }
    }];
}



- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self hideHud];
    if (error.code == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:[error.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [_locationManager requestWhenInUseAuthorization];
            }
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >=9){
//                _locationManager.allowsBackgroundLocationUpdates = YES;
            }
            break;
        case kCLAuthorizationStatusDenied:
        {
            
        }
        default:
            break;
    }
}

#pragma mark - public

- (void)startLocation
{
    if (!_locationManager) {
        // 1. 实例化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 2. 设置代理
        _locationManager.delegate = self;
        // 3. 定位精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        // 4.请求用户权限：分为：⓵只在前台开启定位⓶在后台也可定位，
        //注意：建议只请求⓵和⓶中的一个，如果两个权限都需要，只请求⓶即可，
        //⓵⓶这样的顺序，将导致bug：第一次启动程序后，系统将只请求⓵的权限，⓶的权限系统不会请求，只会在下一次启动应用时请求⓶
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            //[_locationManager requestWhenInUseAuthorization];//⓵只在前台开启定位
            [_locationManager requestAlwaysAuthorization];//⓶在后台也可定位
        }
        // 5.iOS9新特性：将允许出现这种场景：同一app中多个location manager：一些只能在前台定位，另一些可在后台定位（并可随时禁止其后台定位）。
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
//            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
 
    }
    // 6. 更新用户位置
    [_locationManager startUpdatingLocation];
    
    if (_isSendLocation) {
        [self.sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.sendButton setUserInteractionEnabled:NO];
    }
    
    [self showHudInView:self.view hint:NSLocalizedString(@"location.ongoning", @"locating...")];
}

-(void)createAnnotationWithCoords:(CLLocationCoordinate2D)coords
{
    if (_annotation == nil) {
        _annotation = [[MKPointAnnotation alloc] init];
    }
    else{
        [_mapView removeAnnotation:_annotation];
    }
    _annotation.coordinate = coords;
    [_mapView addAnnotation:_annotation];
}

- (void)removeToLocation:(CLLocationCoordinate2D)locationCoordinate
{
    [self hideHud];
    
    _currentLocationCoordinate = locationCoordinate;
    float zoomLevel = 0.01;
    MKCoordinateRegion region = MKCoordinateRegionMake(_currentLocationCoordinate, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    
    if (_isSendLocation) {
        [self.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendButton setUserInteractionEnabled:YES];
    }
    
    [self createAnnotationWithCoords:_currentLocationCoordinate];
}

- (void)sendLocation
{
    if (_delegate && [_delegate respondsToSelector:@selector(sendLocationLatitude:longitude:andAddress:)]) {
        [_delegate sendLocationLatitude:_currentLocationCoordinate.latitude longitude:_currentLocationCoordinate.longitude andAddress:_addressString];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
