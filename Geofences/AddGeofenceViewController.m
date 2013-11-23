//
//  AddGeofenceViewController.m
//  Geofences
//
//  Created by Jose Luis Rodriguez on 28/10/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import "AddGeofenceViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Pin.h"
#import "FencesManager.h"

@interface AddGeofenceViewController ()
@end

@implementation AddGeofenceViewController



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.distanceSlider.continuous=YES;
    self.map.delegate=self;
    self.distanceSlider.enabled=NO;
    
    //FencesManager *fenceMan=[FencesManager sharedManager];
    NSLog(@"%d",[CLLocationManager authorizationStatus]);
    [self performSelector:@selector(setMapRegion) withObject:nil afterDelay:0.1];
    
    
}
#pragma mark Map Set
-(void)setMapRegion{
    
    
    [self.map setRegion:MKCoordinateRegionMakeWithDistance(self.map.userLocation.coordinate, 700, 800) animated:YES];
    
    
}

- (IBAction)locate:(id)sender {
    
    if(self.map.showsUserLocation){
        self.map.showsUserLocation=NO;
        self.locateButton.backgroundColor=[UIColor clearColor];
    }
    else{
        self.map.showsUserLocation=YES;
        self.locateButton.backgroundColor=[UIColor whiteColor];
    }
    
    NSLog(@"%d", self.map.showsUserLocation);
    
}

#pragma mark Set Geofence

-(void)addPinWithCoordinate:(CLLocationCoordinate2D )coordinate{
    
    
    [self.map removeAnnotations:[self.map annotations]];
    [self.map removeOverlays:[self.map overlays]];
    
    [self.map setRegion:MKCoordinateRegionMakeWithDistance(coordinate, 700, 800) animated:YES];
    
    Pin *pin=[[Pin alloc]init];
    pin.coordinate=coordinate;
    pin.userInteractionEnabled =NO;
    pin.canShowCallout=NO;
    [self.map addAnnotation:pin];
    
    MKCircle *circulo=[MKCircle circleWithCenterCoordinate:pin.coordinate radius:self.distanceSlider.value/2];
    [self.map addOverlay:circulo];
    
    
}

- (IBAction)dropPin:(UILongPressGestureRecognizer *)sender {
    if(sender.state==UIGestureRecognizerStateBegan){
        
        self.distanceSlider.enabled=YES;
        NSLog(@"x:%f y:%f", [sender locationInView:self.map].x, [sender locationInView:self.map].y);
        
        [self addPinWithCoordinate:[self.map convertPoint:[sender locationInView:self.map] toCoordinateFromView:self.map]];
    }
    
}



-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKCircleRenderer *circleview=[[MKCircleRenderer alloc]initWithOverlay:overlay];
    circleview.fillColor=[[UIColor blueColor]colorWithAlphaComponent:0.1];
    circleview.strokeColor=[UIColor blueColor];
    
    circleview.lineWidth=1.0;
    
    return circleview;
    
}

- (IBAction)distanceSlide:(UISlider *)sender {
    
    
    
    if(sender.value<200)
        [sender setValue:200];
    else{
        if ((int)sender.value % 100>50){
            
            [sender setValue:sender.value+(100-(int)sender.value % 100) ];
            
        }
        else{
            
            [sender setValue:sender.value-((int)sender.value % 100) ];
            
        }
        
        [self setNewRadius];
        
    }
    
    self.distanceLabel.text=[NSString stringWithFormat:@"%d m", (int)sender.value];
    
    
}

-(void)setNewRadius{
    
    
    MKCircle *circle=[[self.map overlays] objectAtIndex:0];
    circle=[MKCircle circleWithCenterCoordinate:circle.coordinate radius:self.distanceSlider.value/2];
    
    [self.map removeOverlays:[self.map overlays]];
    [self.map addOverlay:circle];
    
}


- (IBAction)addFence:(id)sender {
    
    CLCircularRegion *fence=[[CLCircularRegion alloc]initWithCenter:[[[self.map annotations] objectAtIndex:0] coordinate] radius:self.distanceSlider.value identifier:[NSString stringWithFormat:@"%@", self.identifier.text]];
    
    if(self.fenceType.selectedSegmentIndex==0)
        fence.notifyOnExit=NO;
    else
        fence.notifyOnEntry=NO;
    
    FencesManager *fenceMan=[FencesManager sharedManager];
    
    [fenceMan addGeofenceInRegion:fence];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}

#pragma mark Other View methods
- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.identifier resignFirstResponder];
}




@end
