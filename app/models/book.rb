#
# A book describes a book being brought to the event.
# It is designed for easy entry and viewing, so the author is just a simple
# descriptive string. The type describes general categories: :name, :armory, etc.
#
# Some books have short names which is what they are known in general conversation,
# such as "PicDic" for Pictorial Dictionary of Heraldry.

class Book
  include Mongoid::Document

  field :title, type: String
  field :author, type: String
  field :type, type: Symbol
  field :short_name, type: String
  field :volume, type: Integer

  validates_presence_of :title
  validates_presence_of :type

  def has_author?
    has_attribute? :author
  end

  def has_short_name?
    has_attribute? :short_name
  end

  # Ensures that the ids are converted to strings for assignments
  def key
    id.to_s.freeze
  end
end
