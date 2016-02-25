Mongoid.load! "#{Rails.root}/config/mongoid.yml"

Mongoid.logger.level       = Logger::DEBUG
Mongo::Logger.logger.level = Logger::DEBUG