//
//  Pin.h
//  Mapas
//
//  Created by Jose Luis Rodriguez on 24/03/13.
//  Copyright (c) 2013 Jose Luis Rodriguez. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface Pin : MKAnnotationView<MKAnnotation>{

    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
    
}
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *subtitle;
@end
