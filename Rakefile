require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'echoe'
require 'yaml'

APP_NAME = "sms_xchange"
APP_URL = "http://wiki.globalitcreations.com:8668/space/SMS+Xchange"
APP_DESCRIPTION = "Ruby client for the smsxchange.com service."
AUTHOR_NAME = "Scott Barr"
AUTHOR_EMAIL = "scottb@globalitcreations.com"

#
# Create a version for this build from the config.yml and the BUILD_NUMBER
# environment variable.
#
def get_version
  # read the config file
  config = open("config.yml") {|f| YAML.load(f)}
  
  # build the version number
  version_major = config["version"]["major"]
  version_minor = config["version"]["minor"]  
  version_build = ENV["BUILD_NUMBER"] || "0"
  "#{version_major}.#{version_minor}.#{version_build}"
end

Rake::TestTask.new("test:units") { |t|
  t.pattern = 'test/unit/*_test.rb'
  t.verbose = true
  t.warning = false
}

Rake::TestTask.new("test:integration") { |t|
  t.pattern = 'test/integration/*_test.rb'
  t.verbose = true
  t.warning = false
}

# setup the gem
Echoe.new(APP_NAME, get_version) do |p|
  p.description    = APP_DESCRIPTION
  p.url            = APP_URL
  p.author         = AUTHOR_NAME
  p.email          = AUTHOR_EMAIL
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

task :publish => [:test, :clean, :manifest, :repackage, :upload]

task :upload do
  version = get_version
  
  retval = system "rsync -av pkg/#{APP_NAME}-#{version}.gem git.globalitcreations.com:/var/www/gems.globalitcreations.com/gems/"
  Exception.new("rsync of gem failed") unless retval
  
  retval = system "ssh git.globalitcreations.com 'cd /var/www/gems.globalitcreations.com/ ; gem generate_index'"
  Exception.new("regenerating gem index failed") unless retval
end

# define a remove task method so the "test" task isn't breaking my stuff
Rake::TaskManager.class_eval do
  def remove_task(task_name)
    @tasks.delete(task_name.to_s)
  end
end

# helper method to remove a task
def remove_task(task_name)
  Rake.application.remove_task(task_name)
end

# remove the original test task
remove_task :test

task :test => ["test:units", "test:integration"]
