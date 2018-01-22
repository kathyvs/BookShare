class BookAssignment

  attr_reader :book

  def initialize(book)
    @book = book
    @profile_counts = Hash.new(0)
    @profiles = {}
  end

  def << (assignment_set)
    profile = assignment_set.profile
    profile_counts[profile.id] += assignment_set.count_for(book)
    profiles[profile.id] = profile
  end

  def total_count
    profile_counts.values.sum
  end

  def profile_assignments(&block)
    profile_counts.select do |profile_id, count|
      count > 0
    end.map do |profile_id, count|
      [profiles[profile_id], count]
    end.each(&block)
  end

  #private
    attr_reader :profile_counts
    attr_reader :profiles
end
