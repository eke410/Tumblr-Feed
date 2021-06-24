//
//  PhotosViewController.m
//  Tumblr
//
//  Created by Elizabeth Ke on 6/24/21.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"


@interface PhotosViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;

@end

@implementation PhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:@"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *responseDictionary = dataDictionary[@"response"];
                self.posts = responseDictionary[@"posts"];

                [self.tableView reloadData];
            }
        }];
    [task resume];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    NSDictionary *post = self.posts[indexPath.row];
    NSArray *photos = post[@"photos"];
    
    if (photos) {
        NSDictionary *photo = photos[0];
        NSDictionary *originalSize =  photo[@"original_size"];
        NSString *urlString = originalSize[@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        [cell.photoView setImageWithURL:url];
    }
    
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *post = self.posts[indexPath.row];
        
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.post = post;
}

@end
