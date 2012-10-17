class Article
  include DataMapper::Resource

  property :id,         Serial
  property :title,      String, :length => 128
  property :subtitle,   String, :length => 255
  property :author,     String, :length => 64
  property :published,  Date
  property :content,    Text

  validates_presence_of :title, :subtitle, :author, :published, :content
end
