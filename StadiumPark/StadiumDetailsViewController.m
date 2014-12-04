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
       parameters:@{ @"id":self.stadiumId, @"token":[defaults objectForKey:@"token"], @"email":[defaults objectForKey:@"email"] }
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
    //[self.stadiumNameLabel sizeToFit];
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
    self.priceInfoTextView.text = [NSString stringWithFormat:@"%@\n$%@\n+ $%@ convenience fee", self.priceInfoTextView.text,
                                   [self.stadiumDetails[@"stadium"] objectForKey:@"amount"], [self.stadiumDetails[@"stadium"] objectForKey:@"fee"]];
    [self.priceInfoTextView setFont:[UIFont fontWithName:@"Apple SD Gothic Neo" size:24]];
    [self.priceInfoTextView setTextColor:[UIColor whiteColor]];
    
    //get and set bg color
    if (![[self.stadiumDetails[@"stadium"] objectForKey:@"bg_color"]  isEqual: [NSNull null]]) {
        NSString *stringColor = [self.stadiumDetails[@"stadium"] objectForKey:@"bg_color"];
        NSUInteger red, green, blue;
        sscanf([stringColor UTF8String], "%02X%02X%02X", &red, &green, &blue);
        UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
        [self.priceInfoTextView setBackgroundColor:color];
    }
    
    [self.priceInfoTextView setTextAlignment:NSTextAlignmentCenter];
    [self.view setNeedsDisplay];
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)setLogo {
    NSLog(@"logo: %@", [self.stadiumDetails[@"stadium"] objectForKey:@"logo"]);
    if ([[self.stadiumDetails[@"stadium"] objectForKey:@"logo"]  isEqual: [NSNull null]]) {
        self.stadiumLogoImageView.hidden = YES;
    } else {
        self.stadiumLogoImageView.hidden = NO;
        
        //prepare logo
        //OLDWAY:
        //UIImage *logo = [UIImage imageWithData:[self.stadiumDetails[@"stadium"] objectForKey:@"logo"]];
        //NEW:
        NSString *imgPrefix = @"data:image/png;base64,";
        NSString *logoString = [imgPrefix stringByAppendingString:[self.stadiumDetails[@"stadium"] objectForKey:@"logo"]];
        NSURL *url = [NSURL URLWithString:logoString];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *logo = [UIImage imageWithData:imageData];
        //resize image
        NSString *ratioStr = [self.stadiumDetails[@"stadium"] objectForKey:@"logo_wth"];
        CGFloat ratio = [ratioStr floatValue];
        CGSize newSize = CGSizeMake((CGFloat)100*ratio,100);
        UIGraphicsBeginImageContext(newSize);
        [logo drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
        UIImage *resizedLogo = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.stadiumLogoImageView.frame = CGRectMake((self.view.bounds.size.width - 200) / 2, 79, 200, 100);
        self.stadiumLogoImageView.center = self.view.center;
        self.stadiumLogoImageView.image = resizedLogo;
        //self.stadiumLogoImageView.frame = CGRectMake((self.view.bounds.size.width - 200) / 2, 79, 200, 100);
    }
}

@end
