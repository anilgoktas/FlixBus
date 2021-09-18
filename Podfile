platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

target 'FlixBus' do
  # Pods for FlixBus
  pod 'Alamofire'
  pod 'SwiftyJSON'
  pod 'R.swift'

  target 'FlixBusTests' do
    inherit! :search_paths
    pod 'SwiftyMocky'
  end

  target 'FlixBusSnapshotTests' do
    inherit! :search_paths
    pod 'SwiftyMocky'
    pod 'iOSSnapshotTestCase'
  end

  target 'FlixBusUITests' do
    # Pods for testing
  end

end
