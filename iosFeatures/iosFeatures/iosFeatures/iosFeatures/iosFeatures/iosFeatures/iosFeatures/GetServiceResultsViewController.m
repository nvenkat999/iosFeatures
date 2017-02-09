//
//  GetServiceResultsViewController.m
//  iosLearningProject
//
//  Created by Venkata  naraharisetty on 12/28/16.
//  Copyright © 2016 Venkata  naraharisetty. All rights reserved.
//

#import "GetServiceResultsViewController.h"
#import "GetServiceResultsObject.h"
#import "GetServiceViewController.h"

@interface GetServiceResultsViewController ()


@end

@implementation GetServiceResultsViewController


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    [self maintainThreads];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}

/*
-(void)viewDidAppear:(BOOL)animated{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self startAnimatingView];
        });
        //Implement code here
        //wait(5);
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
        sleep(5);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self stopAnimating];
            [[UIApplication sharedApplication]endIgnoringInteractionEvents];
        });
        
    });
    
} */

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_serviceResultsData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    GetServiceResultsObject *individaulObject = [_serviceResultsData objectAtIndex:indexPath.row];
    cell.textLabel.text = individaulObject.Title;
    // Configure the cell...
    return cell;
}


-(void)getServiceData{
//    [self startAnimatingView];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //[self startAnimatingView];
//            });
        //Implement code here
        //[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        
    NSLog(@"this is activity indicator test");
    
    NSString *smallOptionSelected = _OptionSelected.localizedLowercaseString;
    NSString *FinalOptionSelected = [smallOptionSelected stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *UrlString = [NSString stringWithFormat:@"http://itunes.apple.com/us/rss/top%@/limit=100/json",FinalOptionSelected];
    
    NSURL *otherUrl = [NSURL URLWithString:UrlString];
    
    NSData *otherData = [NSData dataWithContentsOfURL:otherUrl];
    
    
    NSDictionary *jsonrawData = [NSJSONSerialization JSONObjectWithData:otherData options:kNilOptions error:nil];
    
    NSDictionary *feed = [jsonrawData objectForKey:@"feed"];
    
    _jsonData = [feed objectForKey:@"entry"];
    _serviceResultsData = [[NSMutableArray alloc]init];
    
    
    for (int j=0;j< _jsonData.count;j++) {
        NSDictionary *dictTitle = [[_jsonData objectAtIndex:j]objectForKey:@"title"];
        NSString *objTitle = [dictTitle objectForKey:@"label"];
        NSDictionary *dictPrice = [[_jsonData objectAtIndex:j]objectForKey:@"im:price"];
        NSString * objPrice = [dictPrice objectForKey:@"label"];
        NSDictionary *dictCategory = [[_jsonData objectAtIndex:j]objectForKey:@"category"];
        NSDictionary *dict2Category = [dictCategory objectForKey:@"attributes"];
        NSString *objCategory = [dict2Category objectForKey:@"label"];
        NSDictionary *dictArtist = [[_jsonData objectAtIndex:j]objectForKey:@"im:artist"];
        NSString *objArtist = [dictArtist objectForKey:@"label"];
        
        NSMutableArray * arrayImagesRawData = [[_jsonData objectAtIndex:j]valueForKey:@"im:image"];
        NSMutableArray * objArrayImages = [[NSMutableArray alloc]init] ;
        for (int k =0; k<arrayImagesRawData.count ; k++) {
            NSDictionary *dictImg = [arrayImagesRawData objectAtIndex:k];
            NSString *objImg = [dictImg objectForKey:@"label"];
            [objArrayImages addObject:objImg];
            
        }
        
        NSString *objLink;
        if ([[[_jsonData objectAtIndex:j]objectForKey:@"link"] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dictLink = [[_jsonData objectAtIndex:j]objectForKey:@"link"];
            NSDictionary *dictLink2 = [dictLink objectForKey:@"attributes"];
            objLink = [dictLink2 objectForKey:@"href"];
        } else {
            NSMutableArray *arrayLink = [[_jsonData objectAtIndex:j]objectForKey:@"link"];
            NSDictionary *adictLink = [arrayLink objectAtIndex:0];
            NSDictionary *adicLink2 = [adictLink objectForKey:@"attributes"];
            objLink = [adicLink2 objectForKey:@"href"];
        }
        
        
        [_serviceResultsData addObject:[[GetServiceResultsObject alloc]initWithTitle:objTitle andPrice:objPrice andCategory:objCategory andArtist:objArtist andImage: (NSMutableArray *)objArrayImages  andLink:objLink]];
        
            }
        NSLog(@"This is service result %@",_serviceResultsData);
        //[self.tableView reloadData];
        
       // });
    
}

-(void)setActivityIndicator{
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicator.frame = CGRectMake(0.0, 0.0, 400.0, 420.0);
    _activityIndicator.center = self.view.center;
    [self.view addSubview:_activityIndicator];
    [_activityIndicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    
}

-(void)startAnimatingView{
    
    //creating view in background
    
    _backGroundView = [[UIView alloc]initWithFrame:self.view.frame];
    _backGroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_backGroundView];
    
    //creating bezelview
    
    _activityIndicatorView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_activityIndicatorView setBackgroundColor:[UIColor blackColor]];
    _activityIndicatorView.center = self.view.center;
    _activityIndicatorView.layer.cornerRadius = 5.f;
    
    //creating Activity Indicator
    
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityIndicatorView addSubview:_activityIndicator];
    _activityIndicator.center = CGPointMake(_activityIndicatorView.frame.size.width/2, _activityIndicatorView.frame.size.height/2);
    [_activityIndicator startAnimating];
    [self.view addSubview:_activityIndicatorView];
    //sleep(5);
}


-(void)stopAnimatingView{
//    [UIView animateWithDuration:0.3 animations:^{
//        _activityIndicatorView.alpha=0.0;
//    } completion:^(BOOL finished) {
//        [_activityIndicator stopAnimating];
//        //_activityIndicator.hidden = YES;
//        //_activityIndicator.hidesWhenStopped = true;
//    }];
    [_activityIndicator stopAnimating];
    _activityIndicatorView.alpha = 0.0;
    _backGroundView.alpha = 0.0;
    
}


-(void)maintainThreads{
    dispatch_group_t dispatchGroup = dispatch_group_create();
    
    dispatch_queue_t dispatchQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(dispatchGroup, dispatchQueue, ^{
        [self startAnimatingView];
        [self getServiceData];
    });
    dispatch_group_notify(dispatchGroup, dispatch_get_main_queue(), ^{
        //dispatch_release(dispatchGroup);
        NSLog(@"Got request data");
        [self.tableView reloadData];
        [self stopAnimatingView];
        
    });
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
