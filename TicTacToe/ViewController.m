//
//  ViewController.m
//  TicTacToe
//
//  Created by Justin Haar on 3/12/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *labelOne;
@property (weak, nonatomic) IBOutlet UILabel *labelTwo;
@property (weak, nonatomic) IBOutlet UILabel *labelThree;
@property (weak, nonatomic) IBOutlet UILabel *labelFour;
@property (weak, nonatomic) IBOutlet UILabel *labelFive;
@property (weak, nonatomic) IBOutlet UILabel *labelSix;
@property (weak, nonatomic) IBOutlet UILabel *labelSeven;
@property (weak, nonatomic) IBOutlet UILabel *labelEight;
@property (weak, nonatomic) IBOutlet UILabel *labelNine;
@property (weak, nonatomic) IBOutlet UILabel *whichPlayerLabel;

@end

@implementation ViewController
{
    int turn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//first player
self.whichPlayerLabel.text = @"X";

    turn = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];


    //generate Random whichplayer
    if ((turn % 2 ) == 0)
    {
        self.whichPlayerLabel.text = @"X";
    } else {
        self.whichPlayerLabel.text = @"O";
    }


    NSLog(@" current player is %@", self.whichPlayerLabel.text);

    [self findLabelUsingPoint:point];


    if ((turn % 2 ) == 0)
    {
        self.whichPlayerLabel.text = @"O";
    } else {
        self.whichPlayerLabel.text = @"X";
    }


    ++turn;


}


- (void)findLabelUsingPoint:(CGPoint)point
{
    //if point is in this frame?


    if(CGRectContainsPoint(self.labelOne.frame, point)){
            // place X or O
        [self assignLabelValue:self.labelOne];

    }
    else if(CGRectContainsPoint(self.labelTwo.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelTwo];

    }else if(CGRectContainsPoint(self.labelThree.frame, point)){

        // place X or O
        [self assignLabelValue:self.labelThree];

    }else if(CGRectContainsPoint(self.labelFour.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelFour];

    }else if(CGRectContainsPoint(self.labelFive.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelFive];

    }else if(CGRectContainsPoint(self.labelSix.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelSix];

    }else if(CGRectContainsPoint(self.labelSeven.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelSeven];

    }else if(CGRectContainsPoint(self.labelEight.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelEight];

    }else if(CGRectContainsPoint(self.labelNine.frame, point)){
        // place X or O
        [self assignLabelValue:self.labelNine];
    }

}




-(void)assignLabelValue: (UILabel *) label
{
    // place X or O
    if([label.text isEqualToString:@""]){
        if([self.whichPlayerLabel.text isEqualToString:@"X"]){
            label.text= @"X";
            label.textColor = [UIColor blueColor];
        } else {
            label.text= @"O";
            label.textColor = [UIColor redColor];
        }
    }


}







@end
