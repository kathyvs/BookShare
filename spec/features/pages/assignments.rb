module Pages

  class AssignmentsPage
    include Capybara::DSL

    def include_book?(book)
      false
    end
  end
end
