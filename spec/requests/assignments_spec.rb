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

  attr_reader :books, :event

  before(:all) do 
    @event = Event.create! name: "Test Event", month: 8
    @books = []
    3.times do |c|
      number = c + 1
      @books << Book.create!(title: "Book #{number}", author: "Author #{number}")
    end
  end

  def book_id(number)
    @books[number - 1].id
  end

  def to_attrs(attrs)
    result = attrs.clone
    result[:profile_id] = profile_for(attrs[:name_sym]).id
    result.delete(:name_sym)
    return result
  end

  let(:valid_attributes) {
    to_attrs name_sym: :normal, event_id: @event.id, year: 2015,
      bringing: {book_id(1) => 0, book_id(2) => 1}
  }

  let(:invalid_attributes) {
     to_attrs name_sym: :other, year: -100
  }

  describe "GET /events/:event_id/:year/assignments" do

    attr_reader :assignments, :year
    before(:all) do 
      Assignment.delete_all
      @year = 2017
      other_event = Event.create! name: "Other Event", month: 3
      events = [event, event, other_event]
      years = [2016, year, year]
      users = [[:normal], [:normal, :other], [:other]]
      bringing = [[{book_id(1) => 100}],
        [{book_id(1) => 1, book_id(3) => 143}, {book_id(2) => 152, book_id(3) => 153}],
        [{book_id(2) => 100}]]
      @assignments = []
      events.zip(years, users, bringing) do |e, y, ulist, blist|
        ulist.zip(blist) do |usym, b|
          pid = profile_for(usym).id
          a = Assignment.create! event_id: e.id, year: y, profile_id: pid, bringing: b
          @assignments << a if e.id == event.id && y == year
        end
      end
      get event_assignments_path(event, year)
    end

    it "succeeds (even without authentication)" do
      expect(response).to have_http_status(200)
    end

    it "displays all books" do
      books.each do |b|
        expect(response.body).to include(b.title)
      end
    end

    it "displays name for everyone with an assignment for this event" do
      [:normal, :other].each do |s|
        expect(response.body).to include(profile_for(s).name)
      end
    end

    it "displays the count when the count is not 1" do
      [143, 152, 153].each do |c|
        expect(response.body).to include(c.to_s)
      end
    end

  end
end
