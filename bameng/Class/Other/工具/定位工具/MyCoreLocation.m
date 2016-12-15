//
//  MyCoreLocation.m
//  bameng
//
//  Created by lhb on 16/11/11.
//  Copyright © 2016年 HT. All rights reserved.
//

#import "MyCoreLocation.h"

@interface MyCoreLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic, strong) CLGeocoder *geoC;



@end

@implementation MyCoreLocation

- (CLGeocoder *)geoC{
    if (_geoC == nil) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC;
}

- (CLLocationManager *)locationManager{
    if(_locationManager == nil){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 100.0;
        [_locationManager requestWhenInUseAuthorization];
    }
    return _locationManager;
}



+(instancetype)MyCoreLocationShare{
   return [[self alloc] init];
}


- (instancetype)init{
    if (self = [super init]) {
        
        [self locationManager];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusDenied://拒绝
            LWLog(@"拒绝");
            break;
        case kCLAuthorizationStatusAuthorizedAlways://拒绝
            LWLog(@"一直允许");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse://拒绝
            LWLog(@"使用期间允许");
            break;
        default:
            break;
    }
}


- (void)locationManager:(CLLocationManager * )manager didUpdateLocations:(NSArray *)locations{
    CLLocation* location = [locations lastObject];
    NSLog(@"经度:%g,纬度:%g,高度:%g,速度:%g,方向:%g",location.coordinate.latitude,location.coordinate.longitude,location.altitude,location.speed,location.course);
    [manager stopUpdatingLocation];
    
    NSString * lw = [NSString stringWithFormat:@"%g,%g",location.coordinate.latitude,location.coordinate.longitude];
    __weak MyCoreLocation * wself = self;
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
            CLPlacemark *pl = [placemarks firstObject];
            if ([wself.delegate respondsToSelector:@selector(MyCoreLocationTakeBackCity: andLatLong: andFullInfo:)]) {
                [wself.delegate MyCoreLocationTakeBackCity:pl.locality andLatLong:lw andFullInfo:location];
            }
        }else{
            LWLog(@"错误");
        }
    }];
    
}

- (void)MyCoreLocationStartLocal{
    if([CLLocationManager locationServicesEnabled]){
        [_locationManager startUpdatingLocation];
    }else{
        if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }

}

- (void)MyCoreLocationStopLocal{
    
    [_locationManager stopUpdatingLocation];
}


@end
