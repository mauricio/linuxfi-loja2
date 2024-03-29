require 'will_paginate/view_helpers/link_renderer'

class BootstrapLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
  protected

  def html_container(html)
    tag :div, tag(:ul, html), container_attributes
  end

  def page_number(page)
    tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
  end

  def previous_or_next_page(page, text, classname)
    tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
  end
end

WillPaginate::ViewHelpers.class_eval do

  def self.will_paginate(collection = nil, options = {})
    options[:renderer] ||= BootstrapLinkRenderer
    super.try :html_safe
  end

end
