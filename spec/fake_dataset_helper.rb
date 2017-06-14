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
    datastore(kind).values
  end

  def delete key
    datastore(key.kind).delete(key.id)
  end

  private
  
    def next_id
      @next_id ||= -1
      @next_id += 1
    end
    
    def datastore(kind)
      @datastore ||= {}
      @datastore[kind] ||= {}
    end
end