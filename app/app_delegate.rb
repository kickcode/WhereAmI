class AppDelegate
  def applicationDidFinishLaunching(notification)
    buildMenu
    buildWindow

    if CLLocationManager.locationServicesEnabled
      @location_manager = CLLocationManager.alloc.init
      @location_manager.delegate = self
      @location_manager.desiredAccuracy = KCLLocationAccuracyHundredMeters
      @location_manager.startUpdatingLocation
    end
  end

  def buildWindow
    @mainWindow = NSWindow.alloc.initWithContentRect([[240, 180], [480, 360]],
      styleMask: NSTitledWindowMask|NSClosableWindowMask|NSMiniaturizableWindowMask|NSResizableWindowMask,
      backing: NSBackingStoreBuffered,
      defer: false)
    @mainWindow.title = NSBundle.mainBundle.infoDictionary['CFBundleName']
    @mainWindow.orderFrontRegardless
  end

  def locationManager(manager, didFailWithError: error)
    NSLog "[LOCATION] error: #{error.localizedDescription}"
  end

  def locationManager(manager, didChangeAuthorizationStatus: status)
    NSLog "[LOCATION] status: #{status}, authorized: #{status == KCLAuthorizationStatusAuthorized}"
  end

  def locationManager(manager, didUpdateLocations: locations)
    @current_location = locations.first
    NSLog "CURRENT LOCATION: #{@current_location.coordinate.latitude},#{@current_location.coordinate.longitude}"
  end
end
