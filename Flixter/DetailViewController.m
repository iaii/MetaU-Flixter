//
//  DetailViewController.m
//  Flixter
//
//  Created by Apoorva Chilukuri on 6/17/22.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailViewController ()



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (weak, nonatomic) IBOutlet UIImageView *posterImage;

@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;


@end

@implementation DetailViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = self.detailDict[@"title"];
    NSString *synopsis = self.detailDict[@"overview"];

    
    // Do any additional setup after loading the view
    //self.titleLabel.text = self.movieInfo[@"Title"];
    self.titleLabel.text = title;
    self.synopsisLabel.text = synopsis;

    
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    //NSString *posterURLString = movie[@"poster_path"];

    // Backdrop Image
    NSString *backdropPath = self.detailDict[@"backdrop_path"];
    NSString *backdropImageURLString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", backdropPath];
    NSURL *backdropImageURL = [NSURL URLWithString:backdropImageURLString];
//  NSURLRequest *backdropRequest = [NSURLRequest requestWithURL:backdropImageURL];
    
    [self.posterImage setImageWithURL:backdropImageURL];

    // Poster Image
    NSString *posterPath = self.detailDict[@"poster_path"];
    NSString *imageURLString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w200%@", posterPath];
    NSURL *imageURL = [NSURL URLWithString:imageURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];

    // Fetch the movie image:
    [self.movieImageView
     setImageWithURLRequest:request
     placeholderImage:nil
     success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {

    self.movieImageView.image = image;
    [self.movieImageView setNeedsLayout];

    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
