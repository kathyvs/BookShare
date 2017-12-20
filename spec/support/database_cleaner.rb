
RSpec.configure do |config|
  
  config.use_transactional_fixtures = false
 
  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end
 
  config.before(:each) do
    DatabaseCleaner.start
  end
 
  config.after(:each) do
    DatabaseCleaner.clean
  end
  
  ##Add Custom Database Matchers

end
