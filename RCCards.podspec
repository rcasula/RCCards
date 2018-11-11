#
# Be sure to run `pod lib lint RCCards.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RCCards'
  s.version          = '0.1.0'
  s.summary          = 'iOS Cards UI framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  RCCards is an iOS Cards UI framework inspired by CardParts.
                       DESC

  s.homepage         = 'https://github.com/robcas3/RCCards'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Roberto Casula' => 'rcasula3@gmail.com' }
  s.source           = { :git => 'https://github.com/robcas3/RCCards.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'

  s.source_files = 'RCCards/Classes/**/*'
  
  s.resource_bundles = {
    'RCCards' => ['RCCards/Assets/*.xcassets']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'RxSwift', '~> 4.0'
  s.dependency 'RxCocoa', '~> 4.0'
  s.dependency 'RxDataSources', '~> 3.0'
  s.dependency 'RxGesture', '~> 2.0'
  s.dependency 'DeepDiff', '~> 1.3'
  s.dependency 'SnapKit', '~> 4.2'
  # s.dependency 'SwifterSwift', '~> 4.4'
end
