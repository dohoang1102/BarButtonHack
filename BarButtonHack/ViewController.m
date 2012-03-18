//
//  ViewController.m
//  BarButtonHack
//
//  Created by James Martinez on 3/18/12.
//  Copyright (c) 2012 James Martinez. All rights reserved.
//

//////////////
//
/*
 
 This project was created to demo a way to block programatically created UIBarButtonItems from being pushed, even when not touching the button. If you open the project and run it, you'll notice that there is a space between the UIBarButtonItem on the left and the UISegmentedControl. Previously, when tapping in that space, the button closest to it (i.e. the button on the left or the button on the right, not the UISegmentedControl) would be pushed.
 
 Not anymore! :)
 
 NOTE: THIS IS A DISGUSTING HACK. I AM SORRY THAT YOU ARE LOOKING AT THIS
 
 */
//
//////////////

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 34)];
    toolBar.tintColor = [UIColor darkGrayColor];
    
    UISegmentedControl *metricsSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:[NSString stringWithFormat:@"Metric"], [NSString stringWithFormat:@"Imperial"], nil]];
    metricsSegmentedControl.frame = CGRectMake(0, 0, 120, 24);
    metricsSegmentedControl.center = CGPointMake(160, 18);
    metricsSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    metricsSegmentedControl.tintColor = [UIColor darkGrayColor];
    metricsSegmentedControl.selectedSegmentIndex = 0;
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(hideToolsContainer)];
    
    UIBarButtonItem *btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(hideToolsContainer)];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolBar.bounds.size.height, 320, 0)];
    //picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    
    
    // Additional Config
    toolBar.items = [NSArray arrayWithObjects:cancelBarButton, btnSpace, doneBarButton, nil];
    
    [self.view addSubview:toolBar];
    
    
    //START NASTY HACK
    /*
     
     I would have been a little less ashamed if I could have coded this dynamically (instead of 55, 220, etc), but unfortunately I cannot. UIBarButtonItem -width does not return a value unless I have manually set it; it returns 0 which means that it will auto-size. Since there is no way to get the width, I had to play around with numbers to get this to work (which came out to ~55/~220, respectfully). 
     
     I'm sorry that you're reading this. I really am. 
     
     */
    CGFloat x = 55; //where to stop the tapping from
    CGFloat width = 220; //how far to stop the tapping
    CGFloat height = toolBar.frame.size.height;
    CGRect rect = CGRectMake(x, 0, width, height);
    UIView *blockerView = [[UIView alloc]initWithFrame:rect];
    [self.view addSubview:blockerView]; //note: this is after the toolbar, before the seg control
    //END NASTY HACK
    
    
    [self.view addSubview:metricsSegmentedControl];
    [self.view addSubview:picker];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


-(void)hideToolsContainer
{
    NSLog(@"TEST");
}
@end
