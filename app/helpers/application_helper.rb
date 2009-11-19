# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user_allowed?
    !current_user.nil?
  end
  def selected_if(page)
    ' selected ' if @page.permalink && @page.permalink.to_sym == page
  end
end

