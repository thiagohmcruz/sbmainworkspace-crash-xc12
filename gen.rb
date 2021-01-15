require 'cocoapods'

def source_file_contents(framework_name)
  <<EOS
#import <Foundation/Foundation.h>

#import "#{framework_name}.h"

@implementation #{framework_name}

- (void)doSomething {
  NSLog(@"I am #{framework_name}.");
}

@end
EOS
end

def app_source_file_contents(framework_name)
  <<EOS
@import #{framework_name};
int main() { return 0; }
EOS
end

def test_source_file_contents(framework_name)
  <<EOS
@import #{framework_name};
@import XCTest;


@interface #{framework_name}Tests : XCTestCase

@end


@implementation #{framework_name}Tests

- (void)setUp {
}

- (void)testExample {
    XCTAssertTrue(true);
}

@end
EOS
end

def header_file_contents(framework_name)
  <<EOS
@import Foundation;

//! Project version number for #{framework_name}.
FOUNDATION_EXPORT double #{framework_name}VersionNumber;

//! Project version string for #{framework_name}.
FOUNDATION_EXPORT const unsigned char #{framework_name}VersionString[];

@interface #{framework_name} : NSObject

- (void)doSomething;

@end

EOS
end

def create_framework(framework_name)
  FileUtils.mkdir_p(framework_name)

  Dir.chdir(framework_name) do
    File.write("#{framework_name}.h", header_file_contents(framework_name))
    File.write("#{framework_name}.m", source_file_contents(framework_name))

    spec_path = Pathname.new("#{framework_name}.podspec.json")
    spec = Pod::Spec.new do |s|
      s.name = "#{framework_name}"
      s.version = '1.0.0'
      s.author = { 'Sample Large App' => 'large-app@largecompany.com' }
      s.summary = "Generated #{framework_name}."
      s.homepage = 'https://largecompany.com'
      s.source = { git: "https://largecompany.com/#{framework_name}.git", tag: "podify/#{s.version}" }
      s.source_files = '*.{h,m}'

      s.ios.deployment_target = '9.3'

      if framework_name == 'Framework0'
          449.times { |i| s.dependency "Framework#{i+1}"}
      end

      if framework_name == 'Framework0'
        s.test_spec do |test_spec|
          FileUtils.mkdir_p('./Tests')
          File.write("./Tests/#{framework_name}Tests.m", test_source_file_contents(framework_name))
          test_spec.source_files = 'Tests/*.{h,m}'
          449.times { |i| test_spec.dependency "Framework#{i+1}"}
          test_spec.frameworks = 'XCTest'
          test_spec.requires_app_host = true
        end
      end
      if framework_name == 'Framework0'
        s.app_spec do |app_spec|
          FileUtils.mkdir_p('./App')
          File.write("./App/#{framework_name}Tests.m", app_source_file_contents(framework_name))
          app_spec.source_files = 'App/*.{h,m}'
          449.times { |i| app_spec.dependency "Framework#{i+1}"}
        end
      end
    end
    spec_path.dirname.mkpath
    spec_path.open('w') { |f| f.write spec.to_pretty_json }
  end
end

450.times do |i|
  create_framework("Framework#{i}")
end

podfile = Pod::Podfile.new do
  platform :ios, 9.3
  install! 'cocoapods', :generate_multiple_pod_projects => true, :incremental_installation => true
  project 'SampleApp'
  use_frameworks!(linkage: :static)
  target 'SampleApp' do

      450.times do |i|
        framework_name = "Framework#{i}"
        requirements = [{:path => "./#{framework_name}"}]
        if framework_name == 'Framework0'
          requirements << { :testspecs => ['Tests'], appspecs: %w[App] }
        end
        pod "Framework#{i}", *requirements
      end
    target 'SampleAppTests' do
      inherit! :search_paths
    end
  end
end

podfile_path = Pathname.new('CocoaPods.podfile.yaml')
podfile_path.open('w') { |f| f << podfile.to_yaml }

import_path = Pathname.new('SampleApp/Someimport.m')
import_path.open('w') do |f|
  450.times do |i|
    f << "@import Framework#{i};\n"
  end
end
