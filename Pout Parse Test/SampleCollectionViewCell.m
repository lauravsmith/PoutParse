//
//  SampleCollectionViewCell.m
//  Pout Parse Test
//
//  Created by Laura Smith on 2015-08-07.
//  Copyright (c) 2015 Laura Smith. All rights reserved.
//

#import "SampleCollectionViewCell.h"

@implementation SampleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.container = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.imageView = [[PFImageView alloc] initWithFrame:self.contentView.bounds];
        
        [self.contentView addSubview:self.container];
        [self.container addSubview:self.imageView];
        
        self.viewForBaselineLayout.layer.masksToBounds = YES;
    }
    return self;
}

-(void)setObject:(PFObject *)object {
    _object = object;
    PFFile *file;
    if ([object objectForKey:@"thumbnail"]) {
        file = [object objectForKey:@"thumbnail"];
    } else {
        file = [object objectForKey:@"photo"];
    }
    if (file) {
        self.imageView.frame = self.contentView.bounds;
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        self.imageView.file = file;
        [self.imageView loadInBackground];
    }
    
    if ([_object objectForKey:@"videoId"]) {
        self.playImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play.png"]];
        self.playImageView.frame = CGRectMake(self.frame.size.width - 23.0, 10.0, 11.0, 13.0);
        [self.container addSubview:self.playImageView];
    }
}

@end
