module ApplicationHelper
end

module ActionView
  module Helpers
    module AssetTagHelper
      def image_tag(source, options = {})
        options.symbolize_keys!

        src = options[:src] = path_to_image(source)

        unless src =~ /^cid:/
          options[:alt] = options.fetch(:alt){ image_alt(src) }
        end

        if size = options.delete(:size)
          options[:width], options[:height] = size.split("x") if size =~ %r{^\d+x\d+$}
        end

        if mouseover = options.delete(:mouseover)
          options[:onmouseover] = "this.src='#{path_to_image(mouseover)}'"
          options[:onmouseout]  = "this.src='#{src}'"
        end

        unless options.delete(:lazy)
          tag("img", options)
        else
          original_options = options.clone
          options[:src] = path_to_image('grey.png')
          options[:'data-original'] = original_options[:src]
          classes = (options[:class] || '').split(' ')
          classes << 'lazy' unless classes.include? 'lazy'
          options[:class] = classes.join(' ')
          "#{tag("img", options)} #{content_tag(:noscript, tag("img", original_options))}".html_safe
        end
      end
    end
  end
end
