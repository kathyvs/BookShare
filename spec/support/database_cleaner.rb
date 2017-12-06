
RSpec.configure do |config|
  
  config.use_transactional_fixtures = false
 
  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
  end
 
  config.before(:each) do
    puts "Starting DatabaseCleaner\n"
    DatabaseCleaner.start
  end
 
  config.after(:each) do
    DatabaseCleaner.clean
    puts "Ending DatabaseCleaner\n"
  end
end
