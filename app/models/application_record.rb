require 'active_model/conversion'
require 'active_model'

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
  
  def entity_name
    self.class.to_s
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
end
