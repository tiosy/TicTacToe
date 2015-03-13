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
    NSString *whoWon;
    NSInteger integers[10]; // use 1-9; ignore index 0;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    

    //first player
    self.whichPlayerLabel.text = @"X";
    self.whichPlayerLabel.textColor = [UIColor blueColor];
}



- (IBAction)onLabelTapped:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.view];


    NSLog(@" current player is %@", self.whichPlayerLabel.text);

    //assign X or O to tapped Label
    [self findLabelUsingPoint:point];

    [self checkWhoWon];


}


- (void)findLabelUsingPoint:(CGPoint)point
{
    // check if point is in this frame?


    if(CGRectContainsPoint(self.labelOne.frame, point)){

        // place X or O

        integers[1] = [self assignLabelValue:self.labelOne];


    }
    else if(CGRectContainsPoint(self.labelTwo.frame, point)){
        // place X or O
        integers[2] = [self assignLabelValue:self.labelTwo];

    }else if(CGRectContainsPoint(self.labelThree.frame, point)){

        // place X or O
        integers[3] =[self assignLabelValue:self.labelThree];

    }else if(CGRectContainsPoint(self.labelFour.frame, point)){
        // place X or O
        integers[4] =[self assignLabelValue:self.labelFour];

    }else if(CGRectContainsPoint(self.labelFive.frame, point)){
        // place X or O
        integers[5] =[self assignLabelValue:self.labelFive];

    }else if(CGRectContainsPoint(self.labelSix.frame, point)){
        // place X or O
        integers[6] =[self assignLabelValue:self.labelSix];

    }else if(CGRectContainsPoint(self.labelSeven.frame, point)){
        // place X or O
        integers[7] =[self assignLabelValue:self.labelSeven];

    }else if(CGRectContainsPoint(self.labelEight.frame, point)){
        // place X or O
        integers[8] =[self assignLabelValue:self.labelEight];

    }else if(CGRectContainsPoint(self.labelNine.frame, point)){
        // place X or O
        integers[9] =[self assignLabelValue:self.labelNine];
    }

}




-(NSInteger) assignLabelValue: (UILabel *) label
{
    // place X or O
    // if label already has "O" or "X"-> do nothing
    if([label.text isEqualToString:@""]){

        if([self.whichPlayerLabel.text isEqualToString:@"X"]){
            label.text= @"X";
            label.textColor = [UIColor blueColor];
        } else {
            label.text= @"O";
            label.textColor = [UIColor redColor];
        }


        // change to another player
        if([self.whichPlayerLabel.text isEqualToString:@"X"]){
            self.whichPlayerLabel.text = @"O";
            self.whichPlayerLabel.textColor = [UIColor redColor];
        }
        else {
            self.whichPlayerLabel.text = @"X";
            self.whichPlayerLabel.textColor = [UIColor blueColor];
        }
    }

    if([label.text isEqualToString:@"X"]){
        return (NSInteger) 1; // player X
    } else {
        return (NSInteger) 100; // player O
    }

}


-(void) checkWhoWon
{

    // each X = 1; if there are 3 (Xs) in a line, the total is 3 and player X won
    // each O = 100; if there are 3 (Os) in a line, thetotal will be 300 and player O won
    if(
       [self isWon:integers[1] b:integers[2] c:integers[3] total:3]
       || [self isWon:integers[4] b:integers[5] c:integers[6] total:3]
       || [self isWon:integers[7] b:integers[8] c:integers[9] total:3]
       || [self isWon:integers[1] b:integers[4] c:integers[7] total:3]
       || [self isWon:integers[2] b:integers[5] c:integers[8] total:3]
       || [self isWon:integers[3] b:integers[6] c:integers[9] total:3]
       || [self isWon:integers[1] b:integers[5] c:integers[9] total:3]
       || [self isWon:integers[3] b:integers[5] c:integers[5] total:3]
    ){
        self.whichPlayerLabel.text = @"Player X Won";
    }

    if(
       [self isWon:integers[1] b:integers[2] c:integers[3] total:300]
       || [self isWon:integers[4] b:integers[5] c:integers[6] total:300]
       || [self isWon:integers[7] b:integers[8] c:integers[9] total:300]
       || [self isWon:integers[1] b:integers[4] c:integers[7] total:300]
       || [self isWon:integers[2] b:integers[5] c:integers[8] total:300]
       || [self isWon:integers[3] b:integers[6] c:integers[9] total:300]
       || [self isWon:integers[1] b:integers[5] c:integers[9] total:300]
       || [self isWon:integers[3] b:integers[5] c:integers[5] total:300]
       ){
        self.whichPlayerLabel.text = @"Player O Won";
    }

   }

-(BOOL) isWon: (NSInteger)a b: (NSInteger) b c:(NSInteger)c total: (NSInteger)total{

    if((a+b+c) == total){
        return YES;
    }
    else {
        return NO;
    }
}


@end
