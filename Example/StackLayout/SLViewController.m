
#import "SLViewController.h"

#import "UIView+StackLayout.h"

@interface SLViewController ()

@end

@implementation SLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *red = [UIButton buttonWithType:UIButtonTypeCustom];
    red.backgroundColor = [UIColor redColor];
    [red setTitle:@"Red" forState:UIControlStateNormal];
    
    UIButton *green = [UIButton buttonWithType:UIButtonTypeCustom];
    green.backgroundColor = [UIColor greenColor];
    [green setTitle:@"Green" forState:UIControlStateNormal];
    
    UIButton *blue = [UIButton buttonWithType:UIButtonTypeCustom];
    blue.backgroundColor = [UIColor blueColor];
    [blue setTitle:@"Blue" forState:UIControlStateNormal];
    
    UILabel *wrappingLabel = [[UILabel alloc] init];
    [wrappingLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    wrappingLabel.text = @"This is some really long text that will cause the label to wrap to more than one line. Hopefully, when it wraps the layout will adjust the height accordingly. There is no way to know until you try it, though.";
    wrappingLabel.numberOfLines = 0;
    
    UIView *fakeCell = [[UIView alloc] init];
    
    [fakeCell addSubviewsWithHorizontalLayout:@[red, green, wrappingLabel, blue] configurationBlock:^(SLHorizontalStackLayout *layout) {
        layout.spacingPriority = UILayoutPriorityRequired - 2;
        layout.spacing = 20;
        layout.verticalAlignment = SLAlignmentTop;
        layout.horizontalAlignment = SLAlignmentFill;
        [layout setCustomSpacing:0 betweenView:red andView:green];
    }];
    fakeCell.backgroundColor = [UIColor purpleColor];

    // Weakly make the fake cell as small vertically as possibble
    NSLayoutConstraint *heightSmall = [fakeCell.heightAnchor constraintEqualToConstant:0];
    heightSmall.priority = 1;
    heightSmall.active = true;
    
    [self.view addSubviewsWithHorizontalLayout:@[fakeCell] configurationBlock:^(SLHorizontalStackLayout *layout) {
        layout.verticalAlignment = SLAlignmentCenter;
        layout.horizontalAlignment = SLAlignmentCenter;
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
