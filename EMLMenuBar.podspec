Pod::Spec.new do |s|
  s.name             = "EMLMenuBar"
  s.version          = "1.0"
  s.summary          = "Shows a menu tool to navigate through UIViewControllers."
  s.description      = <<-DESC
                        Shows a menu tool to navigate through UIViewControllers. Using a UIScrollView or UIPageViewController.
                       DESC
  s.homepage         = "https://github.com/enricmacias/EMLMenuBar.git"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "enric.macias.lopez" => "enric.macias.lopez@gmail.com" }
  s.source           = { :git => "https://github.com/enricmacias/EMLMenuBar.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'EMLMenuBar' => ['Pod/Assets/*.png']
  }
s.resources = ['Pod/Resources/*.{xib}']

  s.frameworks = 'UIKit', 'MapKit'
end
