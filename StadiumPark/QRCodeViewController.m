//
//  QRCodeViewController.m
//  StadiumPark
//
//  Created by Charles Chandler on 10/23/14.
//  Copyright (c) 2014 Flow Enterprises. All rights reserved.
//

#import "QRCodeViewController.h"

@interface QRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // prep qr text string
    NSString *qrPrefix = @"data:image/png;base64,";
    NSString *fullQRString = [qrPrefix stringByAppendingString:self.qrCode];
    NSURL *url = [NSURL URLWithString:fullQRString];
    
    // create UIImageView
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData];
    CGFloat width = 200;//self.view.bounds.size.width;
    CGFloat positionX = (self.view.bounds.size.width - width) / 2;
    CGFloat positionY = (self.view.bounds.size.height - width) / 2;//self.navigationController.navigationBar.frame.size.height + 16.0;
    UIImageView *imageView = [[UIImageView alloc]
                initWithFrame:CGRectMake(positionX, positionY, width, width)];
    imageView.image = image;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
