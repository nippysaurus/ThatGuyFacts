//
//  DataManager.m
//  ChuckNorrisFacts
//
//  Created by Michael Dawson
//  Copyright (c) 2010 Nippysaurus. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

@synthesize managedObjectModel;
@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;

#pragma mark -
#pragma mark singleton management

static DataManager *instance = nil;

+ (DataManager*)sharedManager
{
    if (instance == nil)
    {
        instance = [[super allocWithZone:NULL] init];
        
        [instance configureManagedObjectContext];
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [[self sharedManager] retain];
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark -
#pragma mark configuration

- (void)configureManagedObjectContext
{
	NSError* error = nil;
    
	NSString* applicationDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]; // autorelease
    
    //NSLog(@"applicationDirectory = %@", applicationDocumentsDirectory);
    NSString *efearg = [[NSBundle mainBundle] pathForResource:@"ChuckNorrisFactsPristine" ofType:@"sqlite"];
    NSLog(@"efearg = %@", efearg);
    
	// sqlite data file url
	NSURL *storeUrl = [NSURL fileURLWithPath: [applicationDocumentsDirectory stringByAppendingPathComponent: @"ChuckNorrisFacts.sqlite"]]; // autorelease
	
    // 
    if ([storeUrl checkResourceIsReachableAndReturnError:&error] == NO) // autorelease
    {
        NSLog(@"moving initial sqlite database into place");
        //
    }
    
	// managed object model
	managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
	
	// persistent store coordinator
	persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

	[persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:storeUrl
                                                   options:nil
                                                     error:&error];
	
	// managed object model
	managedObjectContext = [[NSManagedObjectContext alloc] init];
    
	[managedObjectContext setPersistentStoreCoordinator: persistentStoreCoordinator];
}

- (void)persistData
{
	NSLog(@"persisting data");
	
	BOOL rer = [managedObjectContext hasChanges];
	
	NSLog(@"has changes: %d", rer);
	
	NSError *error;
	
	BOOL success = [managedObjectContext save:&error];
	
	if (!success)
	{
		NSLog(@"error persisting data");
		//[NSApp presentError:error];
	}
	else
	{
		NSLog(@"success");
	}
}

//static int i = 0;
//
//+(void)addFact:(NSString*)fact toContext:(NSManagedObjectContext*)moc
//{
//	Fact *newFact = (Fact*)[NSEntityDescription insertNewObjectForEntityForName:@"Fact"
//														 inManagedObjectContext:moc];
//	
//    [newFact setID:[NSNumber numberWithInt:i++]];
//	[newFact setText:fact];
//	//[newFact setIsFavorite:[NSNumber numberWithBool:NO]];
//}

#pragma mark -
#pragma mark data source helpers

+ (Fact*)getFactWithId:(NSInteger)id
{
    NSLog(@"get fact with id %d", id);
    
    NSManagedObjectContext *moc = [DataManager sharedManager].managedObjectContext;
    [moc retain];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Fact"
    													 inManagedObjectContext:moc];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID=%i", id];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *facts = [[moc executeFetchRequest:request
                                         error:&error] retain];
    
    [moc release];
    
    if (error != nil)
    {
        //
    }
    
    Fact *fact = [facts objectAtIndex:0];
    
    return fact;
}

// total number of facts
+ (NSInteger)numberOfFacts
{
    NSManagedObjectContext *moc = [DataManager sharedManager].managedObjectContext;
    [moc retain];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Fact"
    													 inManagedObjectContext:moc];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entityDescription];
    
    NSError *error;
    
    NSUInteger count = [moc countForFetchRequest:request error:&error];
    
    [moc release];
    
    return count;
}

//+ (NSInteger)numberOfFavoriteFacts
//{
//    NSManagedObjectContext *moc = [DataManager sharedManager].managedObjectContext;
//    [moc retain];
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Fact"
//    													 inManagedObjectContext:moc];
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"IsFavorite=1"];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    
//    [request setEntity:entityDescription];
//    [request setPredicate:predicate];
//    
//    NSError *error;
//    
//    NSUInteger count = [moc countForFetchRequest:request error:&error];
//    
//    [moc release];
//    
//    return count;
//}

//- (NSArray*)idOfFavorites
//{
//    NSLog(@"getting id of favorites");
//    
//    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Fact"
//    													 inManagedObjectContext:managedObjectContext]; // autorelease
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"IsFavorite=1"]; // autorelease
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc] init]; // 1
//    
//    [request setEntity:entityDescription];
//    [request setPredicate:predicate];
//    
//    NSError *error;
//    
//    NSArray *facts = [managedObjectContext executeFetchRequest:request
//                                                         error:&error]; // autorelease
//    
//    [request release];
//
//    NSMutableArray *ids = [[NSMutableArray alloc] init]; // 1
//    
//    for (Fact *fact in facts)
//        [ids addObject:fact.ID];
//    
//    //Fact *fact = [facts objectAtIndex:0];
//    
//    //return fact;
//    
//    NSArray *ids2 = [NSArray arrayWithArray:ids]; // autorelease
//    
//    [ids release];
//    
//    return ids2;
//}

#pragma mark -
#pragma mark memory management

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax; //denotes an object that cannot be released
}

- (void)release
{
    //do nothing
}

- (id)autorelease
{
    return self;
}

@end
