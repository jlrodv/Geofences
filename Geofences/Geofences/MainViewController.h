//
//  MainViewController.h
//  Geofences
//
//  Created by Jose Luis Rodriguez on 28/10/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FencesManager.h"
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) FencesManager *fencesManager;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet MKMapView *mapa;

- (IBAction)deleteFence:(UIButton *)sender;
- (IBAction)stopLoc:(id)sender;
@end
