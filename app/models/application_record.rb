require 'active_model/conversion'
require 'active_model'

class ApplicationRecord
  include ActiveModel::Model
  include ActiveModel::Conversion

  # Return a Google::Cloud::Datastore::Dataset for the configured dataset.
  # The dataset is used to create, read, update, and delete entity objects.
  def self.dataset
    @dataset ||= Google::Cloud::Datastore.new(
      project: Rails.application.config.
                     database_configuration[Rails.env]["dataset_id"]
    )
  end
  
  def persisted? 
    to_key != nil
  end
end
