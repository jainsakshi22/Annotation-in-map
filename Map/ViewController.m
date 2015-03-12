//
//  ViewController.m
//  Map
//
//  Created by Sakshi Jain on 09/03/15.
//  Copyright (c) 2015 Sakshi Jain. All rights reserved.
//

#import "ViewController.h"
#import "MyCustomAnnotation.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *mapAnnotations;

@end

@implementation ViewController


- (void)gotoDefaultLocation
{
    // start off by default in Huda City Centre
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 28.459267;
    newRegion.center.longitude = 77.07268399;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.mapAnnotations = [[NSMutableArray alloc] init];
    
    MyCustomAnnotation *customAnnotion = [[MyCustomAnnotation alloc] init];
    [self.mapAnnotations addObject:customAnnotion];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotations:self.mapAnnotations];
    [self gotoDefaultLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (MKAnnotationView *)mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *returnedAnnotationView = nil;
    
    // in case it's the user location, we already have an annotation, so just return nil.You can also use different if statement for this.
    if (![annotation isKindOfClass:[MKUserLocation class]])
    {
        if ([annotation isKindOfClass:[MyCustomAnnotation class]]) // for Golden Gate Bridge
        {
            returnedAnnotationView = [MyCustomAnnotation createViewAnnotationForMapView:self.mapView annotation:annotation];
            
            UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [rightButton addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
            returnedAnnotationView.rightCalloutAccessoryView = rightButton;
        }
       
    }
    
    return returnedAnnotationView;
}

- (void)gotoByAnnotationClass:(Class)annotationClass
{
    for (id annotation in self.mapAnnotations)
    {
        if ([annotation isKindOfClass:annotationClass])
        {
            // remove any annotations that exist
            [self.mapView removeAnnotations:self.mapView.annotations];
            // add just the city annotation
            [self.mapView addAnnotation:annotation];
            
            [self gotoDefaultLocation];
        }
    }
}

- (IBAction)findLocationPressed:(id)sender
{
    [self gotoByAnnotationClass:[MyCustomAnnotation class]];
}
@end
