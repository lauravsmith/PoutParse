//
//  SampleViewController.m
//  Pout Parse Test
//
//  Created by Laura Smith on 2015-08-07.
//  Copyright (c) 2015 Laura Smith. All rights reserved.
//

#import "SampleViewController.h"
#import "SampleCollectionViewCell.h"

#import <Parse/Parse.h>

#define CELL_IDENTIFIER_2 @"FooterCell"
#define LIMIT 30
#define SPACING 2
#define TILE_SIZE (([[UIScreen mainScreen] bounds].size.width - SPACING *2) / 3)

@interface SampleViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) PFQuery *query;

@end

@implementation SampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(TILE_SIZE, TILE_SIZE)];
    [layout setMinimumInteritemSpacing:SPACING];
    [layout setMinimumLineSpacing:SPACING];
    [layout setFooterReferenceSize:CGSizeMake(self.view.frame.size.width, 60.0)];
    
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height - 52.0) collectionViewLayout:layout];
    [_collectionView setDataSource:self];
    [_collectionView setDelegate:self];
    [_collectionView registerClass:[SampleCollectionViewCell class]
        forCellWithReuseIdentifier:@"cellIdentifier"];
    [_collectionView registerClass:[UICollectionViewCell class]
        forCellWithReuseIdentifier:CELL_IDENTIFIER_2];
    [_collectionView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.collectionView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 50.0) / 2.0, 50.0, 50.0, 50.0)];
    [self.view addSubview:self.activityIndicator];
    
    [self loadPosts];
}

-(void)loadPosts {
    [self.activityIndicator startAnimating];
    
     NSDate *start = [NSDate date];
    
    self.query = [[PFQuery alloc] initWithClassName:@"Post"];
    [self.query orderByDescending:@"createdAt"];
    [self.query includeKey:@"user"];
    [self.query includeKey:@"comment1"];
    [self.query includeKey:@"comment1.user"];
    [self.query includeKey:@"comment2"];
    [self.query includeKey:@"comment2.user"];
    [self.query includeKey:@"comment3"];
    [self.query includeKey:@"comment3.user"];
    [self.query includeKey:@"comment4"];
    [self.query includeKey:@"comment4.user"];
    

    [self.query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.activityIndicator stopAnimating];
            });
            NSDate *methodFinish = [NSDate date];
            NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:start];
            
            NSLog(@"Execution Time: %f", executionTime);
            
            for (PFObject *post in objects) {
                // check if user loaded
                NSLog(@"User %@", [post objectForKey:@"user"]);
            }
            self.dataArray = [[NSMutableArray alloc] initWithArray:objects];
            [self.collectionView reloadData];
        } else {
            NSLog(@"FEED ERROR: %@", [error description]);
        }
    }];
}

#pragma mark UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SampleCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if (!cell) {
        cell = [[SampleCollectionViewCell alloc] init];
    }
    [cell setObject:[self.dataArray objectAtIndex:indexPath.row]];
    cell.backgroundColor=[UIColor whiteColor];
    
    return cell;
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
