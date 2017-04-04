//
//  MapViewController.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/24/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SearchLocationViewController.h"


@interface MapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate,sendDestinationData>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLLocation * startLocation;
@property (nonatomic) MKCoordinateRegion startRegion;
@property (nonatomic) CLLocation * destinationLocation;
@property (nonatomic) CLPlacemark *destinationPlaceMark;
@property (nonatomic,retain) CLGeocoder  *coder;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *selectDestinationButton;

@end
