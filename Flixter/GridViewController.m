//
//  GridViewController.m
//  Flixter
//
//  Created by Apoorva Chilukuri on 6/17/22.
//

#import "GridViewController.h"
#import "CollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"



@interface GridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *results;


@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self fetchMovies];
    
    UICollectionViewFlowLayout *layout = self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    CGFloat postersPerLine = 3;
    CGFloat posterWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing * (postersPerLine - 1)) / postersPerLine;
    CGFloat posterHeight = posterWidth * 1.5;
    layout.itemSize = CGSizeMake(posterWidth, posterHeight);
    
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (self.collectionView.frame.size.width/3.0)-10;
    CGFloat height = 200.0;
    return CGSizeMake(width, height);

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.results.count;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", dataDictionary);
            self.results = dataDictionary[@"results"];
            [self.collectionView reloadData];
        }
    }];
    [task resume];
}


#pragma mark - Navigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UICollectionViewCell *tappedCell = sender;
//    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
//    NSDictionary *movie = self.results[indexPath.item];
//    DetailViewController *detailsViewController = [segue destinationViewController];
//    detailsViewController.movie = movie;
//}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCellViews" forIndexPath:indexPath];
    NSDictionary *movie = self.results[indexPath.item];

    NSString *posterPathString = movie[@"poster_path"];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterPathString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.image.image = nil;
    [cell.image setImageWithURL:posterURL];
    return cell;
}

@end

//
//- (void)viewDidLoad {
//        [super viewDidLoad];
//        self.collectionView.dataSource = self;
//       self.collectionView.delegate = self;
//
//
//       // Create URL
//       NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=698f6f697acc162544b28fb38128879b"];
//
//       // Create Request
//       NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
//
//       // Create Session
//       NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
//
//    //    [self.activityView startAnimating];
//       // Create task
//       NSURLSessionDataTask *task = [
//           session dataTaskWithRequest:request
//           completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//               if (error != nil) {
//                   NSLog(@"%@", [error localizedDescription]);
//               }
//               else {
//                   NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//                   self.results = dataDictionary[@"results"];
//                   [self.collectionView reloadData];
//               }
//    //            [self.activityView stopAnimating];
//           }];
//       [task resume];
//    }
//
//    - (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//        CGFloat width = (self.collectionView.frame.size.width/3.0)-10;
//        CGFloat height = 200.0;
//        return CGSizeMake(width, height);
//
//    }
//
//    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//        return self.results.count;
//    }
//
//    - (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//        return 1;
//    }
//
//    - (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//        CollectionViewCell *movieCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionView" forIndexPath:indexPath];
//
//        NSDictionary *movieInfo = self.results[indexPath.row];
//
//        NSString *posterPath = movieInfo[@"poster_path"];
//
//        NSString *imageURLString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500%@", posterPath];
//        NSURL *imageURL = [NSURL URLWithString:imageURLString];
//        NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
//
//        movieCell.movieCellViews.image = nil;
//
//        [movieCell.movieCellViews
//         setImageWithURLRequest:request
//         placeholderImage: nil
//         success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
//
//            movieCell.movieCellViews.image = image;
//    //        [movieCell setNeedsLayout];
//
//        } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
//            NSLog(@"%@", error);
//        }];
//
//           return movieCell;
//       }
//
//    //- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    //    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:sender];
//    //    NSDictionary *movieInfo = self.results[cellIndexPath.row];
//    //    DetailViewController *detailsVC = [segue destinationViewController];
//    //    detailsVC.movieInfo = movieInfo;
//    //}
//
//    /*
//    #pragma mark - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//
//@end
