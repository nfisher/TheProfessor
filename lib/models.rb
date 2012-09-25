class Person
  include DataMapper::Resource
  property :id,   Serial
  property :firstname, String, :required => true
  property :lastname, String,  :required => true
  property :username, String,  :required => true
  property :uid,  Integer,     :required => true
end

DataMapper.finalize
