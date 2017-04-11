//
//  SearchLocationViewController.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/24/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
//#import "MapViewController.h"

@protocol sendDestinationData <NSObject>

@required
-(void)sendDestinationLocation:(CLLocation *)destLocation andDestinationAddress:(CLPlacemark*)destAddress;

@end

@interface SearchLocationViewController : UIViewController

@property(assign)id<sendDestinationData>destinationDelegate;

- (IBAction)cancelAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property(nonatomic,retain) CLGeocoder *coder;
@property(nonatomic,strong) CLLocation *destinationLocation;
@property (nonatomic,strong) CLPlacemark *destinationPlaceMark;
@end
