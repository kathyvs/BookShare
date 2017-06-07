require 'active_model/conversion'
require 'active_model'
require 'google/cloud/datastore'


class ApplicationRecord
  include ActiveModel::Model
  include ActiveModel::Conversion
  
  attr_accessor :id
   
  # Return a Google::Cloud::Datastore::Dataset for the configured dataset.
  # The dataset is used to create, read, update, and delete entity objects.
  def self.dataset
    @dataset ||= Google::Cloud::Datastore.new(
      project: Rails.application.config.
                     database_configuration[Rails.env]["dataset_id"]
    )
  end
  
  def self.entity_class_name
    return self.to_s
  end

  def self.all
    query = Google::Cloud::Datastore::Query.new
    query.kind entity_class_name

    results = dataset.run query
    results.map {|entity| self.from_entity entity }
  end

  def entity_name
    self.class.entity_class_name
  end
  
  def save
    if valid?
      entity = to_entity
      self.class.dataset.save entity
      self.id = entity.key.id
      true
    else 
      false
    end
  end
  
  def persisted? 
    to_key != nil
  end

   #
  # Used to save to datastore. Subclasses must implement entity_data below.
  #
  def to_entity
    entity = Google::Cloud::Datastore::Entity.new
    entity.key = Google::Cloud::Datastore::Key.new entity_name, id
    add_entity_data(entity)
    entity
  end
  
  protected
    def add_entity_data(entity)
      raise "Implement add_entity_data(entity) to add the data to save."
    end
end
