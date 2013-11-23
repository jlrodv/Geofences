//
//  AddGeofenceViewController.h
//  Geofences
//
//  Created by Jose Luis Rodriguez on 28/10/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AddGeofenceViewController : UIViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *identifier;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UISlider *distanceSlider;
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fenceType;
@property (weak, nonatomic) IBOutlet UIButton *locateButton;


- (IBAction)distanceSlide:(UISlider *)sender;
- (IBAction)locate:(id)sender;
- (IBAction)addFence:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)dropPin:(UILongPressGestureRecognizer *)sender;

@end
