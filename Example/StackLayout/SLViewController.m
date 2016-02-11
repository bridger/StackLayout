
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
    
//    [[[[[[[self.view addSubviewsWithHorizontalLayout:@[red, green]]
//          setLayoutMarginsRelativeArrangement:YES]
//         setLeadingMargin:20]
//        setTrailingMargin:20]
//       setSpacing:10]
//      setHorizontalAlignment:SLAlignmentLeading]
//     setVerticalAlignment:SLAlignmentCenter];
//    
//    blue.translatesAutoresizingMaskIntoConstraints = false;
//    [self.view addSubview:blue];
//    [blue sl_constraintWithSpace:5 followedByView:green isHorizontal:NO].active = true;
//    [blue sl_constraintAligningAttribute:NSLayoutAttributeCenterX withView:green].active = true;
    
    
    UILabel *wrappingLabel = [[UILabel alloc] init];
    [wrappingLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    wrappingLabel.text = @"This is some really long text that will cause the label to wrap to more than one line. Hopefully, when it wraps the layout will adjust the height accordingly. There is no way to know until you try it, though.";
    wrappingLabel.numberOfLines = 0;
    
    UIView *fakeCell = [[UIView alloc] init];
    
    [[[[[fakeCell addSubviewsWithHorizontalLayout:@[red, green, wrappingLabel, blue]]
      setSpacingPriority:UILayoutPriorityRequired - 2]
     setSpacing:20]
      setVerticalAlignment:SLAlignmentTop]
    setSpacing:0 between:red and:green];
    fakeCell.backgroundColor = [UIColor purpleColor];
    
    [[[self.view addSubviewsWithHorizontalLayout:@[fakeCell]]
     setVerticalAlignment:SLAlignmentCenter]
     setHorizontalAlignment:SLAlignmentFill];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
