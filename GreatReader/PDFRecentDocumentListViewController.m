//
//  PDFRecentDocumentListViewController.m
//  GreatReader
//
//  Created by MIYAMOTO Shohei on 2014/02/07.
//  Copyright (c) 2014 MIYAMOTO Shohei. All rights reserved.
//

#import "PDFRecentDocumentListViewController.h"

#import "FileCell.h"
#import "PDFDocumentViewController.h"
#import "PDFRecentDocumentCell.h"
#import "PDFRecentDocumentList.h"

NSString * const PDFRecentDocumentListViewControllerCellIdentifier = @"PDFRecentDocumentListViewControllerCellIdentifier";
NSString * const PDFRecentDocumentListViewControllerSeguePDFDocument = @"PDFRecentDocumentListViewControllerSeguePDFDocument";

@interface PDFRecentDocumentListViewController ()

@end

@implementation PDFRecentDocumentListViewController

- (void)awakeFromNib
{
    NSString *nibName = @"PDFRecentDocumentCell";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nibName = [nibName stringByAppendingString:@"_iPad"];
    } else {
        nibName = [nibName stringByAppendingString:@"_iPhone"];
    }
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:PDFRecentDocumentListViewControllerCellIdentifier];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = self.collectionView.contentInset;
    inset.top = 64;
    inset.bottom = 0;
    self.collectionView.contentInset = inset;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

#pragma mark -

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.documentList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PDFRecentDocumentCell *cell =
            [collectionView dequeueReusableCellWithReuseIdentifier:PDFRecentDocumentListViewControllerCellIdentifier
                                                      forIndexPath:indexPath];

    PDFDocument *document = [self.documentList documentAtIndex:indexPath.row];
    cell.document = document;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:PDFRecentDocumentListViewControllerSeguePDFDocument
                              sender:[collectionView cellForItemAtIndexPath:indexPath]];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{   
    if ([segue.identifier isEqualToString:PDFRecentDocumentListViewControllerSeguePDFDocument]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        PDFDocumentViewController *vc =
                (PDFDocumentViewController *)segue.destinationViewController;
        PDFDocument *document = [self.documentList documentAtIndex:indexPath.row];
        vc.document = [self.documentList open:document];
        vc.documentList = self.documentList;
    }
}

@end