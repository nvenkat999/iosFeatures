//
//  GetServiceDetailViewController.h
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 2/3/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetServiceDetailViewController : UIViewController

@property (strong,nonatomic) NSArray *detailData;
@property (weak, nonatomic) IBOutlet UIImageView *objectImage;
@property (weak, nonatomic) IBOutlet UILabel *objectTitle;
@property (weak, nonatomic) IBOutlet UILabel *objectArtist;
@property (weak, nonatomic) IBOutlet UILabel *objectCategory;
@property (weak, nonatomic) IBOutlet UILabel *objectPrice;
@property (strong, nonatomic) NSArray *detailImageArray;
@property (weak,nonatomic) NSString  *detailImageData;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
