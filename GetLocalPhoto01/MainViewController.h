//
//  MainViewController.h
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLLocalImageViewController.h"

@interface MainViewController : UIViewController <LLLocalImageViewControllerDelegate>
{
    IBOutlet UIButton *clickBtn;
    
    IBOutlet UIImageView *imageView1;
    IBOutlet UIImageView *imageView2;
    IBOutlet UIImageView *imageView3;
    IBOutlet UIImageView *imageView4;
    IBOutlet UIImageView *imageView5;
    
    LLLocalImageViewController *localImageCtrl;
}

@end
