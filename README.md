# Shekly

## Description

Shekly is supposed to be an app designed to help you in your budget management.

## Architecture

This project was started at peak of my love for Rx. But then, ugh, I hated it :D Then my love for CleanSwift begun. 

That said, architecture is a bit of mixture here. One constant here, is separation to modules (targets): 
- Shekly (start module),
- UI,
- Domain, 
- Database, 
- User, 
- Shared, 
- SHTokenField (not used any more, but good candidate for separate pod),
- SheklyShare (kind of dummy share ios extension, just for reading data from json, only for development purposes yet)

It was started with pure Rx, using MVVM + Coordinator. Then hard refactoring appeard, mostly in Domain target. Now, it's still using RxCoordinator for navigation layer, but most of ViewModel's logic is written in pure Swift. There are some Rx left overs, but they appears mainly in not developed sections (like Category an Plan).

## TODO

- [x] upgrade to Swift 5
- [ ] move entirely to CleanSwift
- [x] get rid of Rx
- [x] ~~propably get rid of generic SheklyViewController, since it really affects code readability (can't implement protocols in extensions)~~ actually Swift 5 solves this problem 🎉
- [ ] use ~~Swinject~~ Dip for DI instead of current factories
- [x] introduce SwiftLint
- [x] code style: remove redundant `self.` calls

## Author

Patryk Mieszała, patryk.mieszala@gmail.com
