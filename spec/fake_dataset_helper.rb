class FakeDataset
  
  module WithFakeDataset
    
    def dataset 
      @fake_dataset ||= FakeDataset.new
    end

  end
  
  def lookup key
    kind_map = datastore(key.kind)
    entity = kind_map[key.id]
    if entity
      [entity]
    else 
      []
    end
  end
  
  def save entity
    entity.key.id = next_id unless entity.key.complete?
    datastore(entity.key.kind)[entity.key.id] = entity
  end

  def run query
    kind = query.to_grpc.kind[0]["name"]
    print "Warning: running fake query does not work\n"
    datastore(kind).values
  end

  def delete *entities
    entities.each do |e|
      key = (e.respond_to? :key and e.key or e)
      datastore(key.kind).delete(key.id)
    end
  end

  private
  
    def next_id
      @next_id ||= 10
      @next_id += 1
    end
    
    def datastore(kind)
      @datastore ||= {}
      @datastore[kind] ||= {}
    end
end