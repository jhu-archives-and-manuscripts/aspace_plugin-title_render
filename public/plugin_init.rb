require 'truncate_html'


ArchivesSpacePublic::Application.config.after_initialize do

  ApplicationHelper
  module ApplicationHelper

    def truncate(string, length = 50+40, trailing = '&hellip;')
      return truncate_html(string, length: length, omission: trailing)
    end

  end

end

