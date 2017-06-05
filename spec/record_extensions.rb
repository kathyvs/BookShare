#
# Extendions to persistent models only used by the rpsec tests
#

module RecordExtensions
  
  def create! attributes = nil
    entity = new attributes
    raise "#{entity_name} save failed" unless entity.save
    entity
  end
end