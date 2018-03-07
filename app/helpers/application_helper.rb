module ApplicationHelper

  def button_link_to(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options[:class => 'btn']
    link_to(name, options, html_options, &block)
  end

  def admin?
    current_auth_user && current_auth_user.admin?
  end
end
