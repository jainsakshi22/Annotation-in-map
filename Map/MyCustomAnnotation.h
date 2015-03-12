//
//  MyCustomAnnotation.h
//  Map
//
//  Created by Sakshi Jain on 11/03/15.
//  Copyright (c) 2015 Sakshi Jain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyCustomAnnotation : NSObject <MKAnnotation>
//{
//    CLLocationCoordinate2D coordinate;
//}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

+ (MKAnnotationView *)createViewAnnotationForMapView:(MKMapView *)mapView annotation:(id <MKAnnotation>)annotation;

@end
