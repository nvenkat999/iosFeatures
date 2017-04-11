//
//  GetServiceImageView.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 2/6/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetServiceDetailViewController.h"

@interface GetServiceImageView : UIViewController
@property(strong,nonatomic) NSArray *fullImageArray;
@property NSInteger fullImageIndex;
@property (strong,nonatomic) NSString *fullImageData;
@property (weak, nonatomic) IBOutlet UIImageView *fullImageView;
@property (strong, nonatomic) UIImageView *subImageView;

@end
