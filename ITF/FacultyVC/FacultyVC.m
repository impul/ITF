
//
//  FacultyVC.m
//  ITF
//
//  Created by Impulse on 13.12.16.
//  Copyright © 2016 Impulse. All rights reserved.
//

#import "FacultyVC.h"
#import "FireManager.h"
#import "CoursesTableViewController.h"

@interface FacultyVC ()
@property (strong ,nonatomic) FIRDataSnapshot *snapShot;
@property (strong ,nonatomic) FIRDatabaseReference *fir;
@property (strong ,nonatomic) NSDictionary *ITFdict;
@end

@implementation FacultyVC

#pragma mark LifeCicle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fir = [[FIRDatabase database] reference];
    
    [self.fir observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        self.ITFdict = [snapshot.value objectForKey:@"ITF"];
        [self.tableView reloadData];
    }];
    
}

#pragma mark - TableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cafedraCell" forIndexPath:indexPath];
    cell.textLabel.text = [[self.ITFdict allKeys] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[[self.ITFdict allValues] objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ITFdict.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CoursesTableViewController *coursesTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CoursesTableViewController"];
    [coursesTVC setupControllerWithCourses:[[self.ITFdict allValues]objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:coursesTVC animated:YES];
}

#pragma mark - Private

-(void)generateUsers {
    for (int j = 0 ; j < 5; j++) {
        int count = arc4random()%30;
        for (int i = 0 ; i <count ; i++) {
            [[[[[[self.fir child:@"ITF"] child:@"ES"] child:@"Courses"] child:[NSString stringWithFormat:@"%d",j+1]]childByAutoId] setValue:@{@"Name":[self getRandName]} withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                
            }];
        }
    }
}

-(NSString *)getRandName {
    NSArray *surNameArray = @[@"Abrahamovsky",@"Adamchuk",@"Andreichenko",@"Andriychuk",@"Andreichyn",@"Andreikiv",@"Andreiko",@"Andresyuk",@"Andrichuk",@"Andriyenko",@"Androshchuk",@"Andrukh",@"Andruko",@"Andruntsiv",@"Andrusenko",@"Andrushchenko",@"Andrushkiv",@"Andrushko",@"Andrusiv",@"Andrusyak",@"Andrusyshyn",@"Antonenko",@"Antoniw",@"Artyuschenko",@"Avramenko",@"Archipenko",@"Babiak",@"Bakaj",@"Balanchuk",@"Barabash",@"Belenko",@"Belovol",@"Bilokhatniuk",@"Bohatenko",@"Bondarenko",@"Boreckyi",@"Boyko",@"Brutka",@"Bublik",@"Bulhakow",@"Burgos",@"Bzovsky",@"Vann",@"Veremchuk",@"Vershigora",@"Vovk",@"Vynnychenko",@"Voitenko",@"Voloshyn",@"Vyhovsky",@"Vasilchuk",@"Harasemchuk",@"Halyckyj",@"Holub",@"Hordiyenko",@"Hotopylo",@"Huba",@"Hubenko",@"Hulyahrotsky",@"Hrytsenko",@"Hryshchuk",@"Holowaty",@"Hycha",@"Gogol",@"Gleba",@"Galey",@"Goraya",@"Gulka",@"Gura",@"Gurka",@"Glushenko",@"Gryglewicz",@"Dolouda",@"Danilenko",@"Dobryivechir",@"Doroshenko",@"Evanishyn",@"Ewaschuk",@"Yehorenko",@"Yelenyuk",@"Yeliashkevych",@"Yelyuk",@"Yevdokymenko",@"Yevtukh",@"Yevtushenko",@"Yevtushok",@"Yecoshenko",@"Zherdev",@"Yakimchuk",@"Yarema",@"Ivanenko",@"Yiranek",@"Yovenko",@"Kalashnik",@"Karaszkewycz",@"Karwatsky",@"Katyuk",@"Klimenko",@"Kluka",@"Kobevko",@"Korneluk",@"Kosh",@"Koshla",@"Kovalenko",@"Kovalchick",@"Kovalchuk",@"Kozachenko",@"Kozoriz",@"Kravets",@"Kryvobok",@"Kryvonis",@"Kryvoruchko",@"KrylenkoKudleychuk",@"Koziy",@"Koltasz",@"Koltyk",@"Lazarenko",@"Lukyanenko",@"Lukashenko",@"Leonchuk",@"Liski",@"Loboda",@"Lyakh",@"Ladanchuk",@"Makarenko",@"Mowczan",@"Mandyczewski",@"Marmurchuk",@"Maslak",@"Miroshnychenko",@"Motruk",@"Maryniuk",@"Mykhaylyk",@"Nazarenko",@"Nazdratenko"];
    return [[surNameArray[arc4random()%surNameArray.count] stringByAppendingString:@" "] stringByAppendingString:surNameArray[arc4random()%surNameArray.count]];
}

@end
