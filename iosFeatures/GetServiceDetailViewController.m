//
//  GetServiceDetailViewController.m
//  iosFeatures
//
//  Created by Venkata  naraharisetty on 2/3/17.
//  Copyright © 2017 Venkata  naraharisetty. All rights reserved.
//

#import "GetServiceDetailViewController.h"
#import "GetServiceResultsObject.h"
#import "GetServiceImageView.h"

@interface GetServiceDetailViewController ()

@end

NSInteger imageIndex = 2;
@implementation GetServiceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayData];
    [self addGestureRecognizers];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidLayoutSubviews{
    [_scrollView addSubview:_contentView];
    _scrollView.contentSize = _contentView.frame.size;
    //_scrollView.delegate =self;
}

-(void)displayData{
    GetServiceResultsObject *dataObject = [_detailData objectAtIndex:0];
    self.objectTitle.text = dataObject.Title;
    self.objectArtist.text = dataObject.Artist;
    self.objectCategory.text = dataObject.Category;
    self.objectPrice.text = dataObject.Price;
    _detailImageArray = dataObject.Image;
    _detailImageData = _detailImageArray[imageIndex];
    NSData *Imagedata = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_detailImageData]];
    _objectImage.image = [UIImage imageWithData:Imagedata];
}


-(void) addGestureRecognizers {
    UITapGestureRecognizer *tapImageRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageRecognized:)];
    [self.objectImage addGestureRecognizer:tapImageRecognizer];
    
//    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRecognized:)];
//    [self.objectImage addGestureRecognizer: swipeRecognizer];
}


-(void)tapImageRecognized:(UITapGestureRecognizer *)taprecongizer{
    
    //UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main.storyboard" bundle:nil];
    GetServiceImageView *imageView = [self.storyboard instantiateViewControllerWithIdentifier:@"GetServiceImageScreen"];
    [self.navigationController pushViewController:imageView animated:YES];
    imageView.fullImageArray = _detailImageArray;
    imageView.fullImageIndex = imageIndex;
}

- (IBAction)swipeRecognized:(UIGestureRecognizer *)sender;{
    
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *)sender direction];
    switch (direction) {
        case UISwipeGestureRecognizerDirectionRight:
            NSLog(@"Right swipe");
            imageIndex++;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"Left swipe");
            imageIndex--;
        default:
            break;
    }
    imageIndex = (imageIndex < 0) ? ([_detailImageArray count] -1):
    imageIndex % [_detailImageArray count];
    _detailImageData = _detailImageArray[imageIndex];
    NSData *Imagedata = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:_detailImageData]];
    _objectImage.image = [UIImage imageWithData:Imagedata];
    
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
