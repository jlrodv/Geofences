//
//  FencesManager.h
//  Geofences
//
//  Created by Jose Luis Rodriguez on 28/10/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface FencesManager : CLLocationManager<CLLocationManagerDelegate>

@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;
-(void)addGeofenceInRegion:(CLRegion *)region;
-(void)deleteGeofence:(CLRegion *)region;

@end
