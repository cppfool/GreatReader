//
//  PDFRecentDocumentListViewController.h
//  GreatReader
//
//  Created by MIYAMOTO Shohei on 2014/02/07.
//  Copyright (c) 2014 MIYAMOTO Shohei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PDFRecentDocumentList;

@interface PDFRecentDocumentListViewController : UICollectionViewController
@property (nonatomic, strong) PDFRecentDocumentList *documentList;
@end