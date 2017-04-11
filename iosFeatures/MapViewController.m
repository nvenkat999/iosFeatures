//
//  MapViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/24/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotationView.h"
#import <UIKit/UIKit.h>
#import "SearchLocationViewController.h"

@interface MapViewController ()


@end

@implementation MapViewController

@synthesize locationManager;
@synthesize mapView;
@synthesize startLocation;
@synthesize startRegion;
@synthesize destinationLocation;
@synthesize destinationPlaceMark;
@synthesize coder;

#define dest_lat  34.489f;
#define dest_long  -119.5175f;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setDelegate:self];
    coder = [[CLGeocoder alloc]init];
    [self checkAuthorization];
    [self startLocationService];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{

}

-(void)viewDidAppear:(BOOL)animated{
   
    startRegion.center = startLocation.coordinate;
    startRegion.span.latitudeDelta = 0.05f;
    startRegion.span.longitudeDelta = 0.05f;
    [self.mapView setRegion:startRegion animated:YES];
   
    [self createStartingLocationAnnotation];
    NSLog(@"This is destination %@",destinationPlaceMark);
    NSLog(@"This is start location %@",startLocation);
}



-(void)presentLocationAnnotation{
  
}

-(void)startLocationService{
    self.locationManager =[CLLocationManager new];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager startUpdatingLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
    NSLog(@"location latitude is %f and longitude is %f",location.coordinate.latitude,location.coordinate.longitude);
    if (startLocation == nil){
        startLocation = location;
        [self.locationManager stopUpdatingLocation];
        //[self createStartingLocationAnnotation];
    }
}



-(void)createStartingLocationAnnotation{
    [self.coder reverseGeocodeLocation:startLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *startMark = [placemarks objectAtIndex:0];
        NSLog(@"This is the start address %@",startMark);
        if (startLocation!=nil) {
            MapAnnotationView *ann = [[MapAnnotationView alloc]initWithCoordinate:startLocation.coordinate andTitle:startMark.name andSubTitle:startMark.locality];
            [self.mapView addAnnotation:ann];
        }
    }];
    if (destinationLocation!=nil) {
        MapAnnotationView *destinationAnn = [[MapAnnotationView alloc]initWithCoordinate:destinationLocation.coordinate andTitle:destinationPlaceMark.name andSubTitle:destinationPlaceMark.locality];
        [self.mapView addAnnotation:destinationAnn];
        CLLocationCoordinate2D coordinates[2] = {startLocation.coordinate,destinationLocation.coordinate};
        MKPolyline *line = [MKPolyline polylineWithCoordinates:coordinates count:2];
        [self.mapView addOverlay:line];
        UIButton *startNavigationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect frame = [self.view frame];
        startNavigationButton.frame = CGRectMake(5, frame.size.height-55, 50, 50);
        startNavigationButton.backgroundColor = [UIColor redColor];
        startNavigationButton.tintColor = [UIColor whiteColor];
        startNavigationButton.userInteractionEnabled = true;
        [startNavigationButton setTitle:@"start" forState:UIControlStateNormal];
        [startNavigationButton addTarget:self action:@selector(startNavigation:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:startNavigationButton];
    }
    
}

-(void)startNavigation:(id)selector{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Access alert" message:@"You are leaving from ios features app and opening Maps app, do u wish to continue?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       // MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:destinationPlaceMark];
        MKMapItem *mapItem = [[MKMapItem alloc]initWithPlacemark:(MKPlacemark *)destinationPlaceMark];
        NSMutableDictionary *functions = [[NSMutableDictionary alloc]init];
        [functions setObject:MKLaunchOptionsDirectionsModeDriving forKey:MKLaunchOptionsDirectionsModeKey];
        [mapItem openInMapsWithLaunchOptions:functions];
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertView addAction:okAction];
    [alertView addAction:cancelAction];
    [self presentViewController:alertView animated:YES completion:nil];
}


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
   
    MKPolylineRenderer *lineView = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
    lineView.strokeColor = [UIColor blueColor];
    return lineView;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if(startLocation!=nil || destinationLocation !=nil){
   // MKAnnotationView *view = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"ann"];
    MKAnnotationView *view = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annn"];
    //view.image = [UIImage imageNamed:@"photo_close_icon"];
    view.enabled = YES;
    view.canShowCallout =YES;
    view.tintColor = [UIColor greenColor];
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"photo_close_icon"]];
    view.leftCalloutAccessoryView =  image;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return view;
    }else{
    return nil;
    }
    }


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Address" message:@"Address:" preferredStyle:UIAlertControllerStyleAlert];
    //UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Address" message:@"\%@,\%@,\%@,\%@,\%@",destinationPlaceMark.name,destinationPlaceMark.locality,destinationPlaceMark.postalCode,destinationPlaceMark.administrativeArea,destinationPlaceMark.country preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertView dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alertView addAction:okAction];
    [self presentViewController:alertView animated:YES completion:nil];
}

-(void)destinationLocationLocation{
    
}

-(void)requestReverseGeoCoding{
    [self.coder reverseGeocodeLocation:startLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *mark = [placemarks objectAtIndex:0];
        NSLog(@"This is the address %@",mark);
    }];
}

-(void)checkAuthorization{
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        //[self.locationManager requestWhenInUseAuthorization];
        NSLog(@"Authorzation is given");
    }
    else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus]
             ==kCLAuthorizationStatusRestricted){
        NSLog(@"Access denieed");
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Access alert" message:@"You have declined access to location services, if you want to change it please go to settings screen" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alertView dismissViewControllerAnimated:YES completion:nil];
            
        }];
        UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            
        }];
        [alertView addAction:okAction];
        [alertView addAction:settingsAction];
        [self presentViewController:alertView animated:YES completion:nil];
    }
    else if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        NSLog(@"Cant determine access");
        [self.locationManager requestWhenInUseAuthorization];
        if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse) {
            NSLog(@"Access granted");
        }else{
            NSLog(@"Not granted");
        }
    }
}

- (IBAction)selectDestinationAction:(id)sender {
    SearchLocationViewController *searchView = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchLocationViewController"];
    //[[SearchLocationViewController alloc]init];
    searchView.destinationDelegate = self;
    //[searchView setDestinationDelegate:self];
    [self.navigationController presentViewController:searchView animated:YES completion:nil];
    
    if ([searchView destinationDelegate]==nil) {
        NSLog(@"Delegate is nil");
    }else{
        NSLog(@"Delegate is not nil");
    }
}


//#pragma mark Protocol Methods

-(void)sendDestinationLocation:(CLLocation *)destLocation andDestinationAddress:(CLPlacemark *)destAddress
{
    destinationLocation = destLocation;
    destinationPlaceMark =destAddress;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
