which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Hombrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install mint
brew list cocoapods || brew install cocoapods

rm -r Shekly-generated.xcodeproj
rm -r Shekly-generated.xcworkspace

mint run yonaskolb/XcodeGen@2.13.1 xcodegen
mint install mac-cain13/R.swift@v5.2.0
mint install realm/SwiftLint@0.39.1
pod install

open Shekly-generated.xcworkspace