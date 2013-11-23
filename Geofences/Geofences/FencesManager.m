//
//  FencesManager.m
//  Geofences
//
//  Created by Jose Luis Rodriguez on 28/10/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import "FencesManager.h"

@implementation FencesManager


+ (id)sharedManager {
    static FencesManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        _someProperty = @"Default Property Value";
        self.delegate=self;
       // self.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

-(void)addGeofenceInRegion:(CLRegion *)region{
    NSLog(@"added region");

    
    
    [self startMonitoringForRegion:region];
    
    NSLog(@"%f", self.maximumRegionMonitoringDistance);
    
    
    
}

-(void)deleteGeofence:(CLRegion *)region{

    [self stopMonitoringForRegion:region];

}


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"enter region: %@", region.identifier);
    
    
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"exit region %@", region.identifier);
    
}
-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
    NSLog(@"monitoring delegate");
    
    [self requestStateForRegion:region];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
    
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error{

    NSLog(@"er:%@", error);

}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    if(state==CLRegionStateInside)
    NSLog(@"inside");
    else if(state==CLRegionStateOutside)
        NSLog(@"outside");
    else
        NSLog(@"unknown");
}

@end
