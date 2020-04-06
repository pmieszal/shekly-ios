which -s brew
if [[ $? != 0 ]] ; then
    echo "Installing Hombrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install mint
rm -r Shekly-generated.xcodeproj
mint run yonaskolb/XcodeGen@2.13.1 xcodegen
mint install mac-cain13/R.swift@v5.1.0
mint install realm/SwiftLint@0.39.1