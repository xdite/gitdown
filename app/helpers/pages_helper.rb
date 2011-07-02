module PagesHelper
  def render_post_content(content)
    markdown = RDiscount.new(content).to_html
    raw markdown
  end
end
