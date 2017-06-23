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
    query.run
  end

  # Returns the entity with the given (integer) id or nil if it is not present
  def self.find id
    entity = self.lookup id
    from_entity entity if entity
  end

  def self.query
    Query.new(self)
  end

  class Query

    def initialize(record_class)
      @record_class = record_class
      @query = Google::Cloud::Datastore::Query.new
      @query.kind @record_class.entity_class_name
    end

    def where(method, op, value)
      @query = @query.where(method.to_s, op, value)
      self
    end

    def run
      results = @record_class.dataset.run @query
      results.map {|entity| @record_class.from_entity entity }
    end

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

  def update attributes
    attributes.each do |name, value|
      send "#{name}=", value if respond_to? "#{name}="
    end
    save
  end

  def destroy
    self.class.dataset.delete entity_key
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

  def reload
    entity = self.class.lookup id
    copy_from_entity(entity)
  end
  
  protected

    def entity_key
      Google::Cloud::Datastore::Key.new entity_name, id
    end

    def add_entity_data(entity)
      raise "Implement add_entity_data(entity) to add the data to save."
    end

    def self.from_entity(entity) 
      obj = self.new id: entity.key.id
      obj.copy_from_entity(entity)
      obj
    end

    def copy_from_entity(entity)
      raise "Implement copy_from_entity to copy date from entity to this object"
    end

  private

    def self.lookup id
      query  = Google::Cloud::Datastore::Key.new entity_class_name, id.to_i
      print "Query is #{query}"
      entities = dataset.lookup query
      puts ", result is #{entities}\n"
      entities.first if entities.any?
    end
end
