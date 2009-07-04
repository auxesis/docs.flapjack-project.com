require 'rubygems'
require 'rake'
require 'fileutils'

desc "freeze deps"
task :deps do

  deps = {'sinatra' => "= 0.9.2",
          'yajl-ruby' => "= 0.5.6"}

  puts "\ninstalling dependencies. this will take a few minutes."

  deps.each_pair do |dep, version|
    next if Dir.glob("gems/gems/#{dep}-#{version.split.last}").size > 0
    puts "\ninstalling #{dep} (#{version})"
    system("gem install #{dep} --version '#{version}' -i gems --no-rdoc --no-ri")
  end

end
