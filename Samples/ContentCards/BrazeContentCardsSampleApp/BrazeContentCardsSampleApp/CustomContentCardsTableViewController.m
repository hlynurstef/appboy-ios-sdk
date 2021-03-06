#import "CustomContentCardsTableViewController.h"
#include <objc/runtime.h>

@implementation CustomContentCardsTableViewController

- (instancetype)init {
  self = [super init];
  object_setClass(self, [CustomContentCardsTableViewController class]);
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tableView.backgroundColor = [UIColor blackColor];
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
  if ([cell isKindOfClass:[ABKBaseContentCardCell class]]) {
    ABKBaseContentCardCell *cardCell = (ABKBaseContentCardCell *)cell;
    cardCell.rootView.backgroundColor = [UIColor lightGrayColor];
    cardCell.rootView.layer.borderColor = [UIColor purpleColor].CGColor;
    cardCell.unviewedLineView.backgroundColor = [UIColor redColor];
    
    if ([cardCell isKindOfClass:[ABKCaptionedImageContentCardCell class]]) {
      ((ABKCaptionedImageContentCardCell *)cardCell).TitleBackgroundView.backgroundColor = [UIColor darkGrayColor];
      ((ABKCaptionedImageContentCardCell *)cardCell).titleLabel.textColor = [UIColor brownColor];
    }
  }
  return cell;
}

- (void)handleCardClick:(ABKContentCard *)card {
  NSLog(@"The card %@ is clicked.", card.idString);
  
  [super handleCardClick:card];
}

- (void)populateContentCards {
  NSMutableArray<ABKContentCard *> *cards = [NSMutableArray arrayWithArray:[Appboy.sharedInstance.contentCardsController getContentCards]];
  for (ABKContentCard *card in cards) {
    // Replaces the card description for all Classic content cards
    if ([card class] == [ABKClassicContentCard class]) {
      ((ABKClassicContentCard *)card).cardDescription = @"Custom Feed Override title [classic cards only]!";
    }
  }
  super.cards = cards;
}

@end
