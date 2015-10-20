//
//  LLLocalImageViewController.m
//  GetLocalPhoto01
//
//  Created by lyc on 15/3/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "LLLocalImageViewController.h"
#import "LLLocalImageCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define CELL_NAME @"LLLocalImageCollectionViewCell"

@interface LLLocalImageViewController ()
{
    NSMutableArray *photoImages;
}

@end

@implementation LLLocalImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    endBtn.enabled = NO;
    endBtn.backgroundColor = [UIColor clearColor];
    endBtn.layer.cornerRadius = 5;
    countImageView.hidden = YES;
    countLabel.hidden = YES;
    
    ALAssetsLibrary *_assetsLibrary = [[ALAssetsLibrary alloc] init];
    
    photoImages = [[NSMutableArray alloc] init];
    
    ///ALAssetsGroupLibrary
    [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos|ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        [group setAssetsFilter:[ALAssetsFilter allPhotos]];
        [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if(result){
                UIImage *img = [UIImage imageWithCGImage:result.thumbnail];
                if(img)
                {
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                    [dic setObject:img forKey:@"img"];
                    [dic setObject:@"0" forKey:@"flag"];
                    [photoImages addObject:dic];
                }
                if(index + 1 == group.numberOfAssets)
                {
                    ///最后一个刷新界面
                    [self finish];
                }
            }
        }];
    } failureBlock:^(NSError *error) {
        // error
        NSLog(@"error ==> %@",error.localizedDescription);
    }];
}

- (void)finish
{
    mCollectionView.delegate = self;
    mCollectionView.dataSource = self;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [photoImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView registerNib:[UINib nibWithNibName:CELL_NAME bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CELL_NAME];
    LLLocalImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_NAME forIndexPath:indexPath];
    cell.selectImageView.tag = indexPath.row;
    if (indexPath.row < [photoImages count])
    {
        id dic = [photoImages objectAtIndex:indexPath.row];
        [cell sendValue:dic];
    }
    return cell;
}

#pragma mark - ---UICollectionViewDelegateFlowLayout
// 设置每个View的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemWH = [UIScreen mainScreen].bounds.size.width / 4.0f - 16;
    return CGSizeMake(itemWH, itemWH);
}

// 设置每个图片的Margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LLLocalImageCollectionViewCell *cell = (LLLocalImageCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    id dic = [photoImages objectAtIndex:indexPath.row];
    BOOL flag = [[dic objectForKey:@"flag"] boolValue];
    if (!flag)
    {
        [dic setObject:@"1" forKey:@"flag"];
    } else {
        [dic setObject:@"0" forKey:@"flag"];
    }
    [cell setSelectFlag:!flag];
    
    NSInteger selectCount = [self getSelectImageCount];
    if (selectCount > 0)
    {
        endBtn.enabled = YES;
        endBtn.backgroundColor = [UIColor colorWithRed:134/255.0f green:208/255.0f blue:0/255.0f alpha:1];
        countImageView.hidden = NO;
        countLabel.hidden = NO;
        countLabel.text = [NSString stringWithFormat:@"%ld", selectCount];
    } else {
        endBtn.enabled = NO;
        endBtn.backgroundColor = [UIColor clearColor];
        countImageView.hidden = YES;
        countLabel.hidden = YES;
    }
}

/**
 *  获取列表中有多少Image被选中
 *
 *  @return 选中个数
 */
- (NSInteger)getSelectImageCount
{
    NSInteger count = 0;
    for (NSInteger i = 0; i < [photoImages count]; i++)
    {
        id dic = [photoImages objectAtIndex:i];
        BOOL flag = [[dic objectForKey:@"flag"] boolValue];
        if (flag)
        {
            count++;
        }
    }
    return count;
}

/**
 *  完成按钮点击
 */
- (IBAction)endBtnClick:(id)sender
{
    NSLog(@"完成按钮点击");
    if ([self.delegate respondsToSelector:@selector(getSelectImage:)])
    {
        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in photoImages)
        {
            if ([[dic objectForKey:@"flag"] boolValue])
            {
                [imageArr addObject:[dic objectForKey:@"img"]];
            }
        }
        [self.delegate getSelectImage:imageArr];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
