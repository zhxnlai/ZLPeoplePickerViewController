ZLPeoplePickerViewController
============================

A drop-in contact picker that supports UILocalized​Indexed​Collation

Preview
---

Features
---
- `ZLPeoplePickerViewController` implements UILocalized​Indexed​Collation using [LRIndexedCollationWithSearch](https://gist.github.com/305676/c128784d22fcf572d3beded690ce84f85449d7c7)
- Search (iOS 8)
- multiple selection, great for sending mail

Usage
---
Check out the [demo app]() for an example.

ZLPeoplePickerViewController

init using
~~~objective-c
self.peoplePicker = [[ZLPeoplePickerViewController alloc] init];
self.peoplePicker.delegate = self;
[self.navigationController pushViewController:self.peoplePicker animated:YES];
~~~

convenient method for presenting modally.
~~~objective-c
self.peoplePicker = [ZLPeoplePickerViewController presentPeoplePickerViewControllerForParentViewController:self];
~~~

fieldmask

~~~objective-c
@property (nonatomic) ZLContactField filedMask;
~~~

delegate
~~~objective-c
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker didSelectPerson:(NSNumber *)recordId;
- (void)peoplePickerViewController:(ZLPeoplePickerViewController *)peoplePicker didReturnWithSelectedPeople:(NSArray *)people;

~~~

CocoaPods
---
You can install `ZLPeoplePickerViewController` through CocoaPods adding the following to your Podfile:

    pod 'ZLPeoplePickerViewController'

Depandency
---
`ZLPeoplePickerViewController` uses `APAddressBook` internally. It requires [APAddressBook](https://github.com/Alterplay/APAddressBook).


Requirements
---
- iOS 8 or higher.
- Automatic Reference Counting (ARC).

License
---
ZLPeoplePickerViewController is available under MIT license. See the LICENSE file for more info.
