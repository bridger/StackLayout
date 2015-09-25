
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
    
    [[[[[[[self.view addSubviewsWithHorizontalLayout:@[red, green]]
          setLayoutMarginsRelativeArrangement:YES]
         setLeadingMargin:20]
        setTrailingMargin:20]
       setSpacing:10]
      setHorizontalAlignment:ALAlignmentLeading]
     setVerticalAlignment:ALAlignmentCenter];
    
    blue.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:blue];
    [blue sl_constraintWithSpace:5 followedByView:green isHorizontal:NO].active = true;
    [blue sl_constraintAligningAttribute:NSLayoutAttributeCenterX withView:green].active = true;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
