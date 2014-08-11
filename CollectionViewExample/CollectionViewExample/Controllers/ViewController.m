//
//  ViewController.m
//  CollectionViewExample
//
//  Created by Guido Marucci Blas on 8/10/14.
//  Copyright (c) 2014 Wolox. All rights reserved.
//

#import "ViewController.h"

#import "ProductRepository.h"
#import "ProductViewController.h"
#import "ProductCollectionViewModel.h"
#import "ProductCollectionViewController.h"
#import "ProductCollectionViewControllerDelegate.h"

static NSString * const ShowProductSegue = @"ShowProduct";

@interface ViewController ()<ProductCollectionViewControllerDelegate>

@property(nonatomic) ProductViewModel * selectedProduct;
@property(nonatomic) ProductCollectionViewController * productCollection;
@property(nonatomic) ProductCollectionViewController * favoritedProductCollection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initProductCollections];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:ShowProductSegue]) {
        ProductViewController * controller = segue.destinationViewController;
        controller.viewModel = self.selectedProduct;
    }
}

#pragma mark - ProductCollectionViewController Delegate Methods

- (void)productCollection:(ProductCollectionViewController *)productCollection
         didSelectProduct:(ProductViewModel *)product {
    self.selectedProduct = product;
    [self performSegueWithIdentifier:ShowProductSegue sender:self];
}

#pragma mark - Private Methods

- (ProductCollectionViewController *)createProductCollectionViewController {
    id<ProductRepository> repository = [[Application sharedInstance] productRepository];
    ProductCollectionViewModel * viewModel = [[ProductCollectionViewModel alloc] initWithRepository:repository];
    ProductCollectionViewController * controller = [[ProductCollectionViewController alloc] initWithViewModel:viewModel];
    controller.delegate = self;
    return controller;
}

- (void)initProductCollections {
    self.productCollection = [self createProductCollectionViewController];
    [self.productCollectionView addSubview:self.productCollection.view];
    
    self.favoritedProductCollection = [self createProductCollectionViewController];
    [self.favoritedProductsCollectionView addSubview:self.favoritedProductCollection.view];
}

@end