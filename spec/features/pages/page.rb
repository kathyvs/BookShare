
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
    protected 
    module PageElement
    end
  end


end