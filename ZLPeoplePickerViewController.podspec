Pod::Spec.new do |s|
  s.name         = "ZLPeoplePickerViewController"
  s.version      = "0.0.2"
  s.summary      = "A drop-in contact picker that supports UILocalized​Indexed​Collation."

  s.description  = <<-DESC
                   ZLPeoplePickerViewController is a drop-in contact picker that supports UILocalized​Indexed​Collation.

                   Features:
                   ---
                   - Supports multilingual indexing and sorting by implementing UILocalized​Indexed​Collation using LRIndexedCollationWithSearch.
                   - Supports searching by name, emails and addresses. The results are displayed using UISearchController in iOS 8.
                   - Supports multiple selection.
                   - Supports field mask for filtering contacts.
                   DESC

  s.homepage     = "https://github.com/zhxnlai/ZLPeoplePickerViewController"
  s.screenshots  = "https://raw.githubusercontent.com/zhxnlai/ZLPeoplePickerViewController/master/Previews/personVCPreview.gif", "https://raw.githubusercontent.com/zhxnlai/ZLPeoplePickerViewController/master/Previews/emailsPreview.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Zhixuan Lai" => "zhxnlai@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/zhxnlai/ZLPeoplePickerViewController.git", :tag => "0.0.2" }
  s.source_files = "ZLPeoplePickerViewController", "ZLPeoplePickerViewController/**/*.{h,m}"
  s.frameworks   = "UIKit", "AddressBook", "AddressBookUI"
  s.requires_arc = true
  s.dependency "APAddressBook"
end
