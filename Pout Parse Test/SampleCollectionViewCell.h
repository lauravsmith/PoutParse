//
//  SampleCollectionViewCell.h
//  Pout Parse Test
//
//  Created by Laura Smith on 2015-08-07.
//  Copyright (c) 2015 Laura Smith. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface SampleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) PFImageView *imageView;
@property (nonatomic, strong) PFObject *object;

@end
