class Person
  include DataMapper::Resource
  property :id,   Serial
  property :firstname, String,      :required => true
  property :lastname, String,       :required => true
  property :username, String,       :required => true
  property :uid,  Integer,          :required => true
  property :authorized_keys, Text,  :lazy => true

  validates_presence_of :firstname, :lastname, :username, :uid
end
