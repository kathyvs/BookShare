require 'rails_helper'
require 'record_extensions'
require 'fake_dataset_helper'
require 'auth_helper'

RSpec.describe "Assignments", type: :request do

  Assignment.extend RecordExtensions
  Assignment.extend FakeDataset::WithFakeDataset
  Book.extend RecordExtensions
  Book.extend FakeDataset::WithFakeDataset
  Event.extend RecordExtensions
  Event.extend FakeDataset::WithFakeDataset

  include AuthHelper

  AuthHelper.use_fake_for_profiles

  before(:all) do 
    @event = Event.create! name: "Test Event", month: 8
    @book_ids = []
    3.times do |c|
      number = c + 1
      book = Book.create! title: "Book #{number}", author: "Author #{number}"
      @book_ids << book.id
    end
  end

  def book(number)
    @book_ids[number - 1]
  end

  def to_attrs(attrs)
    attrs[:name] = profile_for(attrs[:name_sym].id)
  end

  let(:valid_attributes) {
    to_attrs name_sym: :normal, event: @event.id, year: 2015, 
      bringing: {book(1) => 0, book(2) => 1}
  }

  let(:invalid_attributes) {
     to_attrs name_sym: :other, year: -100
  }

  describe "GET /assignments" do
    it "works! (now write some real specs)" do
      get assignments_path
      expect(response).to have_http_status(200)
    end
  end
end
