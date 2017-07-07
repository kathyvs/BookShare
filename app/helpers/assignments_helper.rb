module AssignmentsHelper
  
  include UserHelper
  
  def profile_for pid
    profiles[pid] = Profile.find(pid) unless profiles.has_key?(pid)
    return profiles[pid]
  end
  
  def select_for_book(book, assignments)
    assignments.select do |a|
      a.bringing.has_key?(book.id)
    end
  end
  
  def name_link(assignment)
    text = profile_for(assignment.profile_id).name
    if admin_or_assignment_user(assignment) #current_user && current_user.profile.id = assignment.profile_id
      return link_to(text, 
        event_user_assignments_path(assignment.event_id, assignment.year, assignment.id))
    else
      return text
    end
  end
  
  private
    def profiles
      @profiles ||= {}
    end
    
    def admin_or_assignment_user(a)
      current_user.present? && 
        (current_user.admin? || current_user.profile.id == a.profile_id)
    end
end
