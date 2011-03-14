//
//  TableCell.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell

- (id)initWithCoder:(NSCoder *)coder
{
    if ((self = [super initWithCoder:coder]))
    {
        // configure label
        UILabel *label = (UILabel*)[self viewWithTag:LABEL_TAG];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        //[label setMinimumFontSize:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)prepareForReuse
{
    NSLog(@"prepareForReuse:");
}

// fact getter
-(Fact*)fact
{
    return fact;
}

// fact setter
-(void)setFact:(Fact *)f
{
    fact = f;
    
    UILabel *label = (UILabel*)[self viewWithTag:LABEL_TAG];
    
    [label setText:f.Text];
    
    [self adjustSize];
}

// private
+(CGSize)sizeForFact:(Fact*)fact
{
	CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), 20000.0f);
	
	CGSize size = [fact.Text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE]
                        constrainedToSize:constraint
                            lineBreakMode:UILineBreakModeWordWrap];
    
    return size;
}

-(void)adjustSize
{
	//CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), 20000.0f);
	
	//CGSize size = [fact.Text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE]
	//					constrainedToSize:constraint
	//						lineBreakMode:UILineBreakModeWordWrap];
    
    CGSize size = [TableCell sizeForFact:fact];
	
    UILabel *label = (UILabel*)[self viewWithTag:LABEL_TAG];
    
	[label setText:fact.Text];
	[label setFrame:CGRectMake(CELL_CONTENT_MARGIN_LEFT, CELL_CONTENT_MARGIN_TOP, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), MAX(size.height, 2.0f))];
}

+(CGFloat)cellHeightForFact:(Fact*)fact
{
	//CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN_LEFT + CELL_CONTENT_MARGIN_RIGHT), 20000.0f);
	
	//CGSize size = [fact.Text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE]
    //                    constrainedToSize:constraint
    //                        lineBreakMode:UILineBreakModeWordWrap];
	
    CGSize size = [TableCell sizeForFact:fact];
    
	CGFloat height = MAX(size.height, 2.0f);
	
    return height + CELL_CONTENT_MARGIN_TOP + CELL_CONTENT_MARGIN_BOTTOM;
}

@end
