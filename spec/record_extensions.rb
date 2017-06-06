#
# Extendions to persistent models only used by the rpsec tests
#

module RecordExtensions
  
  def create! attributes = nil
    entity = new attributes
    raise "#{entity_name} save failed" unless entity.save
    entity
  end
  
  def delete_all
    query = Google::Cloud::Datastore::Query.new.kind entity_name
    loop do
      books = dataset.run query
      if books.empty?
        break
      else
        dataset.delete(*books)
      end
    end
  end
end
