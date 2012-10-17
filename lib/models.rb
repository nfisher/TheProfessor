%w{person article}.each { |m| require File.join(File.dirname(__FILE__), 'models', m) }

DataMapper.finalize
