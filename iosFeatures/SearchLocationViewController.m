//
//  SearchLocationViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 1/24/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "SearchLocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"

@interface SearchLocationViewController ()


@end


@implementation SearchLocationViewController
@synthesize coder;
@synthesize destinationLocation;
@synthesize destinationPlaceMark;
@synthesize destinationDelegate;


- (void)viewDidLoad {
    [super viewDidLoad];
    coder = [[CLGeocoder alloc]init];
    if (destinationDelegate==nil) {
        NSLog(@"Destination is nill");
    }else{
        NSLog(@"Destination is not nill");
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchAction:(id)sender {
    [self.coder geocodeAddressString:self.searchTextField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(!error){
            for (CLPlacemark *placemark in placemarks) {
                if ([placemarks count] >0) {
                    CLPlacemark *firstPlacemark = [placemarks objectAtIndex:0];
                    destinationLocation = [[CLLocation alloc]initWithLatitude:firstPlacemark.location.coordinate.latitude longitude:firstPlacemark.location.coordinate.longitude];
                    //NSLog(@"This is the location coordinate %@",destinationLocation);
                    [self.coder reverseGeocodeLocation:destinationLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                        destinationPlaceMark = [placemarks objectAtIndex:0];
                        
                        NSLog(@"This is the destination address %@",destinationPlaceMark);                        self.addressTextView.text = [NSString stringWithFormat:@"\%@,\%@,\%@,\%@,\%@ " , destinationPlaceMark.name,destinationPlaceMark.locality,destinationPlaceMark.postalCode,destinationPlaceMark.administrativeArea,destinationPlaceMark.country];
                    }];
                    
                }
            }
        }else{
            UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"Access alert" message:@"Sorry, cannot find address based on value entered, please try again" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertView dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertView addAction:okAction];
            [self presentViewController:alertView animated:YES completion:nil];
        }
    }];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)selectAddressAction:(id)sender {
    
    if(destinationDelegate !=nil){
        [self.destinationDelegate sendDestinationLocation:destinationLocation andDestinationAddress:destinationPlaceMark];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    //MapViewController * mapview;
    //mapview.destinationLocation = destinationLocation;
    //mapview.destinationPlaceMark = destinationPlaceMark;
    
}


@end
