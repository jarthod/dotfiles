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
  if defined? Mongoid
    Mongoid.logger = logger
    Moped.logger = logger
  end
end

loud_logger