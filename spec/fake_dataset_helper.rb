class FakeDataset
  
  module WithFakeDataset
    
    def dataset 
      @fake_dataset ||= FakeDataset.new
    end
  end
  
  
  def save entity
    entity.key.id = next_id unless entity.key.complete?
    datastore(entity.key.kind)[entity.key.id] = entity
    print entity.to_json
  end

  private
  
    def next_id
      @next_id ||= -1
      @next_id += 1
    end
    
    def datastore(kind)
      @datastore ||= {}
      @datastore[kind] = {}
    end
end