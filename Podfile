source 'https://github.com/CocoaPods/Specs.git'
#platform :ios, '7.0'

#inhibit_all_warnings!
xcodeproj 'graph-API-search.xcodeproj'

#pod 'WSCoachMarksView', :head
#pod 'SDWebImage', :head
#pod 'TOMSMorphingLabel', '~> 0.5'
##pod 'Parse'
#pod 'ISO8601-re2c'
#pod 'SVPullToRefresh'
#pod 'TBQuadTree'
#pod 'AFNetworking'
#
#target 'WatchKit Extension', :exclusive => true do
#    pod 'AFNetworking'
#end
#
#target 'dtac-iserviceTests', :exclusive => true  do
##  pod 'Expecta',     '>= 0.2.1'   # expecta matchersp
##  pod 'OCMock', '3.0.2'
#  pod 'OHHTTPStubs'
#end
#
#post_install do |installer_representation|
#    installer_representation.pods_project.targets.each do |target|
#        if target.name == "Pods-WatchKit Extension-AFNetworking"
#            target.build_configurations.each do |config|
#                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)', 'AF_APP_EXTENSIONS=1']
#            end
#        end
#    end
#end

#use_frameworks!
def shared_pods
    # pod 'AFNetworking', '~>3.0'
#     pod 'Parse'

end
target 'graph-API-search' do
    platform :ios, '7.0'
    shared_pods
    pod 'WSCoachMarksView', :head
    # pod 'SDWebImage'
    # pod 'TOMSMorphingLabel', '~> 0.5'
    #pod 'Parse'
    # pod 'ISO8601-re2c'
    # pod 'SVPullToRefresh'
    #pod 'TBQuadTree'
    # pod 'HMSegmentedControl'
#    pod 'PureLayout'
    # pod 'iCarousel'
    # pod 'FXBlurView'
#    pod 'iOSaffiliate', :git => 'https://github.com/dtacmobile/iOSaffiliate.git', :branch => 'develop'
    # pod 'SVProgressHUD', :head
    # pod 'CCHMapClusterController'
    # pod 'IDMPhotoBrowser'
    # pod 'TMCache'
    # pod 'UICountingLabel'
    # pod 'HACBarChart'
    # pod 'JPSThumbnailAnnotation'
end
# target 'beta' do
#     platform :ios, '7.0'
#     shared_pods
#     pod 'WSCoachMarksView', :head
#     pod 'SDWebImage'
#     pod 'TOMSMorphingLabel', '~> 0.5'
#     #pod 'Parse'
#     pod 'ISO8601-re2c'
#     pod 'SVPullToRefresh'
#     #pod 'TBQuadTree'
#     pod 'HMSegmentedControl'
#     pod 'PureLayout'
#     pod 'iCarousel'
#     pod 'FXBlurView'
#     pod 'SVProgressHUD', :head
#     pod 'IDMPhotoBrowser'
#     pod 'TMCache'
#     pod 'UICountingLabel'
#     pod 'HACBarChart'
# end
# target 'WatchKit Extension' do
#     platform :watchos, '2.0'
#     shared_pods
# #    pod 'AFNetworking'
# end
target 'graph-API-searchTests' do
    platform :ios, '7.0'
#    shared_pods
    pod 'OHHTTPStubs'
end

# post_install do |installer|
#     app_plist = "dtac-iservice/dtac-iservice-Info.plist"
#     plist_buddy = "/usr/libexec/PlistBuddy"
#     version = `#{plist_buddy} -c "Print CFBundleShortVersionString" "#{app_plist}"`.strip
#     puts "Updating Pods version numbers to #{version}"
#
#
#     installer.pods_project.targets.each do |target|
#         `#{plist_buddy} -c "Set CFBundleShortVersionString #{version}" "Pods/Target Support Files/#{target}/Info.plist"`
#     end
# end
