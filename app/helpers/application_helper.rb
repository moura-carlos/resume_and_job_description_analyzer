module ApplicationHelper
    def markdown_to_html(markdown_text)
      renderer = Redcarpet::Render::HTML.new(filter_html: true, hard_wrap: true)
      markdown = Redcarpet::Markdown.new(renderer, extensions = {})
      markdown.render(markdown_text).html_safe
    end
  end
  