require 'features/pages/page'
#
# Pages for when viewing or editing events
#
module Pages

  #
  # Page for editing or creating an event
  #
  class EditEventPage < Page

    def name=(name)
      fill_in 'event[name]', with: name
    end

    def month=(month)
      select month, from: 'event[month]'
    end

    def submit
      click_button('Create Event')
      binding.pry
      if has_css?("#error_explanation")
        yield this
      else
        yield EditEventAssignmentsPage.new
      end
    end

  end

  class EditEventAssignmentsPage < Page
  end

end
