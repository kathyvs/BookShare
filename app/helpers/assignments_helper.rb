module AssignmentsHelper
  
  def profile_for pid
    profiles[pid] = Profile.find(pid) unless profiles.has_key?(pid)
    return profiles[pid]
  end
  
  def select_for_book(book, assignments)
    assignments.select do |a|
      a.bringing.has_key?(book.id)
    end
  end
  
  private
    def profiles
      @profiles ||= {}
    end
end
