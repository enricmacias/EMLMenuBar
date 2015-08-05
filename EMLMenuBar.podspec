Pod::Spec.new do |s|
  s.name             = "EMLMenuBar"
  s.version          = "1.1"
  s.summary          = "Shows a menu tool to navigate through UIViewControllers."
  s.description      = <<-DESC
                        Shows a menu tool to navigate through UIViewControllers. Using a UIScrollView or UIPageViewController.
                       DESC
  s.homepage         = "https://github.com/enricmacias/EMLMenuBar.git"
  s.screenshots     = "https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/screenshot1.png", "https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/screenshot2.png", "https://raw.github.com/enricmacias/EMLMenuBar/master/Preview/screenshot3.png"
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

  s.frameworks = 'UIKit'
end
