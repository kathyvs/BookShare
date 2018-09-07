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

    def table
      EditBookCountsTable.new(wrap(find("table.table")))
    end

    def submit
      click_button('Create Event')
      if has_css?("#error_explanation")
        yield this
      else
        yield ViewEventPage.new
      end
    end

  end

  class ViewEventPage < Page
  end

  class EditBookCountsTable < PageTable
    NAME_TEXT = {
      parker: 'Parker, James',
      ssno: 'Taszycki, Witold',
      bahlow: 'Bahlow, Hans and Edda Gentry',
      nmj: 'Sólveig Þróndardóttir'
    }

    def initialize(node)
      super node
    end

    def at_row(sym)
      EditBookCountsRow.new(find_row {|r| r.find("td.author").text == NAME_TEXT[sym]})
    end
  end

  class EditBookCountsRow < TableRow

    def initialize(row)
      super row
    end

    def books=(value)
      input = row.find("input")
      row.fill_in(input['id'], with: value)
    end

  end
end
