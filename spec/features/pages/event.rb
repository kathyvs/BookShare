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
      if has_css?("#error_explanation")
        yield this
      else
        yield EditEventCountsPage.new
      end
    end

  end

  class EditEventCountsPage < Page
  end

end
