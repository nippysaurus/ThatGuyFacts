//
//  TableCell.h
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataManager.h"

#define LABEL_TAG 5

#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN_LEFT 8.0f
#define CELL_CONTENT_MARGIN_RIGHT 8.0f
#define CELL_CONTENT_MARGIN_TOP 4.0f
#define CELL_CONTENT_MARGIN_BOTTOM 4.0f

@interface TableCell : UITableViewCell {

    Fact *fact;
    
}

@property (nonatomic, retain) IBOutlet Fact *fact;

-(void)adjustSize;

+(CGFloat)cellHeightForFact:(Fact*)fact;

@end
