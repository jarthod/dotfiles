require 'logger'

def loud_logger
  set_logger_to Logger.new(STDOUT)
end

def quiet_logger
  set_logger_to nil
end

def set_logger_to(logger)
  if defined? ActiveRecord::Base
    ActiveRecord::Base.logger = logger
    ActiveRecord::Base.clear_reloadable_connections!
  end
  Mongoid.logger = logger if defined? Mongoid
  Moped.logger = logger if defined? Moped
  Mongo::Logger.logger = logger if defined? Mongo
end

loud_logger