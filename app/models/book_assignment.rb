class BookAssignment

  include GetOrUse

  attr_reader :book

  def initialize(book)
    @book = book
    @profile_counts = Hash.new(0)
    @profiles = {}
  end

  def << (assignment_set)
    profile_id = assignment_set.profile_id
    profile_counts[profile_id] += assignment_set[book]
    profiles[profile_id] = assignment_set.profile
  end

  def total_count
    profile_counts.values.sum
  end

  def [](profile_or_id)
    return profile_counts[get_or_use(profile_or_id, :id)]
  end

  def profile_assignments(&block)
    profile_counts.select do |profile_id, count|
      count > 0
    end.map do |profile_id, count|
      [profiles[profile_id], count]
    end.each(&block)
  end

  def as_json(*args)
    result = super.as_json(*args)
    result['profile_assignments']= profile_assignments.map do |profile, count|
      {'profile' => profile.as_json,
       'count' => count}
    end
    result
  end

  #private
    attr_reader :profile_counts
    attr_reader :profiles
end
