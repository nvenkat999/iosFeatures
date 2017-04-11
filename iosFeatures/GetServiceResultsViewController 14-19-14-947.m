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
    [self getServiceData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
