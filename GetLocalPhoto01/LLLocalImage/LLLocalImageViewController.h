//
//  LLLocalImageViewController.h
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLLocalImageViewControllerDelegate <NSObject>

- (void)getSelectImage:(NSArray *)imageArr;

@end

@interface LLLocalImageViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView *mCollectionView;
    
    IBOutlet UIButton *endBtn;
    IBOutlet UIImageView *countImageView;
    IBOutlet UILabel *countLabel;
}

@property (assign, nonatomic)id<LLLocalImageViewControllerDelegate> delegate;

@end
