# frozen_string_literal: true

module ApplicationHelper
    def emojify(content)
        index = Emoji::Index.new
        h(content).to_str.gsub(/:([\w+-]+):/) do |match|
          if emoji = index.find_by_moji($1)
            %(<img alt="#$1" src="#{image_path("emoji/#{emoji.image_filename}")}" style="vertical-align:middle" width="20" height="20" />)
          else
            match
          end
        end.html_safe if content.present?
      end
end
