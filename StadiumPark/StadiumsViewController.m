//
//  StadiumsViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "StadiumsViewController.h"
#import "StadiumDetailsViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface StadiumsViewController ()

@property NSArray *stadiums;
@property NSDictionary *currentStadium;

@end

@implementation StadiumsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:@"http://54.69.129.75/braintree_server/laravel/public/index.php/stadiums"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             //store resulting token to user's settings
             NSLog(@"stadium response: %@", operation.responseString);
             self.stadiums = [[NSArray alloc] initWithArray:responseObject];
             [self.stadiumsPicker reloadAllComponents];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             // Handle failure communicating with your server
             NSLog(@"stadium response error: %@", error.description);
         }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickView datasource and delegate method implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.stadiums.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *rowString = [NSString stringWithFormat:@"%@", [[self.stadiums objectAtIndex:row] objectForKey:@"name"]];
    return rowString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentStadium = self.stadiums[row];
    [self performSegueWithIdentifier:@"segueToStadiumDetails" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    StadiumDetailsViewController *controller = segue.destinationViewController;
    controller.stadiumName = [self.currentStadium objectForKey:@"name"];
    controller.stadiumId = [self.currentStadium objectForKey:@"id"];
}

@end
