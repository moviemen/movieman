#config/initializers/resque.rb
require 'resque/server'
require 'resque/scheduler/server'
require 'active_scheduler'

uri = URI.parse("redis://localhost:6379/")  
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }

Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }

yaml_schedule    = YAML.load_file("#{Rails.root}/config/resque_schedule.yml") || {}
wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap yaml_schedule
Resque.schedule  = wrapped_schedule

Resque::Server.use(Rack::Auth::Basic) do |user, password|
  user = 'admin'
  password = 'admin'
end
