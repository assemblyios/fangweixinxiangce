//
//  MainViewController.m
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    localImageCtrl = [[LLLocalImageViewController alloc] init];
    localImageCtrl.delegate = self;
    
    //修改
}

- (IBAction)clickBtn:(id)sender
{
    [self.navigationController pushViewController:localImageCtrl animated:YES];
}

- (void)getSelectImage:(NSArray *)imageArr
{
    
    //i konw
    imageView1.image = [UIImage imageNamed:@""];
    imageView2.image = [UIImage imageNamed:@""];
    imageView3.image = [UIImage imageNamed:@""];
    imageView4.image = [UIImage imageNamed:@""];
    imageView5.image = [UIImage imageNamed:@""];
    
    imageView1.image = [imageArr objectAtIndex:0];
    if ([imageArr count] > 1)
    {
        imageView2.image = [imageArr objectAtIndex:1];
    }
    if ([imageArr count] > 2)
    {
        imageView3.image = [imageArr objectAtIndex:2];
    }
    if ([imageArr count] > 3)
    {
        imageView4.image = [imageArr objectAtIndex:3];
    }
    if ([imageArr count] > 4)
    {
        imageView5.image = [imageArr objectAtIndex:4];
    }
}

@end
