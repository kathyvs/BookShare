
module Pages

  class Page
    include Capybara::DSL

    def nav_bar
      Pages::NavigationBar.new
    end

    def notice
      wrap(find("#notice"))
    end

    def wrap(elem)
      elem.extend(PageElement)
    end

    def signin_as(profile_name)
      raise "Not yet implemented"
    end

    def status
      case status_code
      when 200
        :success
      when 401
        :unauthorized
      when 403
        :forbidden
      else
        status_code
      end
    end

    protected
    module PageElement
    end
  end

  class PageTable
  end

  class ErrorPage < Page
  end


end
