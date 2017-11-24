
#
#  Requires valid_attributes to return a hash
#
module Validation
  
  def create_with_replaced(cls, attrs)
    new_attrs = valid_attributes.merge(attrs)
    cls.new(new_attrs)
  end

  RSpec::Matchers.define :be_valid_at do |keys|
    match do |entity|
      entity.valid? || (entity.errors.keys != [keys])
    end
  
    # Optional failure messages
    failure_message do |actual|
      "TBD"
    end
  
    failure_message_when_negated do |actual|
      if actual.valid? then
        "Expected #{actual} to be invalid, but is was valid"
      else 
        "Expected #{actual} to be invalid at #{keys}, but the errors are #{actual.errors.messages}"
      end
    end
  
    # Optional method description
    description do
      "checks that an entity is valid, or if not valid, that it is not valid in different fields than specified"
    end
  end
end