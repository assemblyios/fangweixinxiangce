//
//  LLLocalImageCollectionViewCell.h
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLLocalImageCollectionViewCell : UICollectionViewCell
{
    BOOL selectFlag;
}

@property (retain, nonatomic)IBOutlet UIImageView *imageView;
@property (retain, nonatomic)IBOutlet UIImageView *selectImageView;

- (void)sendValue:(id)dic;
- (void)setSelectFlag:(BOOL)flag;

@end
