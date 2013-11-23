//
//  MainViewController.m
//  Geofences
//
//  Created by Jose Luis Rodriguez on 28/10/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import "MainViewController.h"



@interface MainViewController ()

@property (nonatomic,strong) NSArray *fences;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _fencesManager=[FencesManager sharedManager];
    
    self.table.dataSource=self;
    self.table.delegate=self;
    
    	// Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    _fences=[[_fencesManager monitoredRegions] allObjects];
    
    
    
    NSLog(@"%@", _fences);
   
    
    [self.table reloadData];
    
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fences.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"celda"];
    
    
    
    cell.textLabel.text=[(CLCircularRegion *)[_fences objectAtIndex:indexPath.row] identifier];
    return cell;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)deleteFence:(UIButton *)sender {
    
    UITableViewCell *cell=(UITableViewCell *)[sender superview];
    
    NSIndexPath *cellPath=[self.table indexPathForCell:cell];
    
    [_fencesManager deleteGeofence:[_fences objectAtIndex:cellPath.row]];
    
    _fences=[[_fencesManager monitoredRegions] allObjects];
    
    
    [self.table reloadData];
    
}

- (IBAction)stopLoc:(id)sender {
    self.mapa.showsUserLocation=NO;
}




    


@end
