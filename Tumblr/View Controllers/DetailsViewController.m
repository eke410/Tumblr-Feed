//
//  DetailsViewController.m
//  Tumblr
//
//  Created by Elizabeth Ke on 6/24/21.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSLog(self.titleLabel.text);
    self.captionLabel.text = self.post[@"caption"];
    self.captionLabel.text = [self.post[@"caption"] substringFromIndex:4];
    [self.captionLabel sizeToFit];
    
    NSArray *photos = self.post[@"photos"];
    if (photos) {
        NSDictionary *photo = photos[0];
        NSDictionary *originalSize =  photo[@"original_size"];
        NSString *urlString = originalSize[@"url"];
        NSURL *url = [NSURL URLWithString:urlString];
        [self.photoView setImageWithURL:url];
    }


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
