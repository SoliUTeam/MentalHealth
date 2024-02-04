generate: package
	xed .

clear:
	rm -rf $HOME/.swiftpm/xcode/
	echo "Removing Derived Data..."
	rm -rf ~/Library/Developer/Xcode/DerivedData/
	
	# 2
	echo "Removing Device Support..."
	rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport
	rm -rf ~/Library/Developer/Xcode/watchOS\ DeviceSupport
	rm -rf ~/Library/Developer/Xcode/tvOS\ DeviceSupport
	
	# 3
	echo "Removing old simulators..."
	xcrun simctl delete unavailable
	
	# 4
	echo "Removing caches..."
	rm -rf ~/Library/Caches/com.apple.dt.Xcode
	rm -rf ~/Library/Caches/org.carthage.CarthageKit

package:
	swift package reset
	echo "SPM Reset is done"
	swift package resolve
