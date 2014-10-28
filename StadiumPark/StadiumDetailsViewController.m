//
//  StadiumDetailsViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "StadiumDetailsViewController.h"
#import "QRCodeViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface StadiumDetailsViewController ()

@property NSDictionary *stadiumDetails;

-(void)setPriceInfo;
-(void)setLogo;

@end

@implementation StadiumDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:@"http://54.69.129.75/braintree_server/laravel/public/index.php/stadium_details"
       parameters:@{ @"id":self.stadiumId, @"token":[defaults objectForKey:@"token"]}
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             NSLog(@"stadium_details response: %@", responseObject[0]);
             self.stadiumDetails = [[NSDictionary alloc] initWithDictionary:responseObject[0]];
             NSLog(@"amount: %@", [self.stadiumDetails[@"stadium"] objectForKey:@"amount"]);
             NSLog(@"qr: %@", [self.stadiumDetails objectForKey:@"qr"]);
             [self setLogo];
             [self setPriceInfo];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"stadium_details response error: %@", error.description);
         }];
    
    // setup view
    self.stadiumNameLabel.text = self.stadiumName;
}

#pragma mark - IBAction methods

- (IBAction)showQRCode:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueToQRCode" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QRCodeViewController *controller = segue.destinationViewController;
    controller.qrCode = [self.stadiumDetails objectForKey:@"qr"];
}

#pragma mark - Private methods
- (void)setPriceInfo {
    self.priceInfoTextView.text = [NSString stringWithFormat:@"%@\n$%@", self.priceInfoTextView.text,
                                   [self.stadiumDetails[@"stadium"] objectForKey:@"amount"]];
    [self.priceInfoTextView setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:34]];
    [self.priceInfoTextView setTextColor:[UIColor whiteColor]];
    [self.priceInfoTextView setTextAlignment:NSTextAlignmentCenter];
    [self.view setNeedsDisplay];
}

- (void)setLogo {
    NSLog(@"logo: %@", [self.stadiumDetails[@"stadium"] objectForKey:@"logo"]);
    if ([[self.stadiumDetails[@"stadium"] objectForKey:@"logo"]  isEqual: [NSNull null]]) {
        UIImage *placeholderImage = [UIImage imageNamed:@"background1" inBundle:nil compatibleWithTraitCollection:nil];
        self.stadiumLogoImageView.image = placeholderImage;
    } else {
        UIImage *logo = [UIImage imageWithData:[self.stadiumDetails[@"stadium"] objectForKey:@"logo"]];
        self.stadiumLogoImageView.image = logo;
    }
}

@end
