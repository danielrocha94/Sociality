module ApplicationHelper

  def full_title(page_title = '')
    base_title = "Sociality"
    if !page_title.empty?
      base_title = page_title + " | " + base_title
    end
  end

end
