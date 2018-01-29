#
# An event is a description of an annual event to where the books are to be
# brought.
#
class Event

  include Mongoid::Document
  include GetOrUse

  field :name, type: String
  field :month, type: Integer

  has_many :assignment_sets do
    def for_year(year)
      return self.where(year: year)
    end
  end

  MIN_MONTH = 1
  MAX_MONTH = 12

  validates_presence_of :name, :month
  validates_numericality_of :month, only_integer: true,
      less_than_or_equal_to: MAX_MONTH,
      greater_than_or_equal_to: MIN_MONTH

  def self.all_months
    return (MIN_MONTH .. MAX_MONTH)
  end

  #
  # Gives the current event, either based on the id, or the one closest to
  # the current month without being past it.
  #
  # TODO: add more cleverness as per pending specs.
  def self.current(id = nil)
    query = Event.where(id: id)
    return query.exists? ? query.first : Event.first
  end

  def month=(month)
    write_attribute(:month, get_or_use(month, :mon))
  end

  def month_name
    Date::MONTHNAMES[month.to_i]
  end
end
