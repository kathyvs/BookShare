module ApplicationHelper

  def button_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options[:class => 'btn']
    link_to(name, options, html_options, &block)
  end
end
