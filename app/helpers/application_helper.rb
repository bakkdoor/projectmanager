# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # helper-methods von acts_as_taggable-plugin.
  include TagsHelper

  # gibt das aktuelle projekt oder (falls nicht vorhanden) nil zurück.
  def current_project
    if params[:project_id]
      Project.find(params[:project_id])
    elsif params[:controller].to_s == "projects" && params[:id]
      Project.find(params[:id])
    else
      nil
    end
  end

  def german_months
    %w(Januar Februar März April Mai Juni Juli August September Oktober November Dezember)
  end

  def work_hours
    #(0..10).to_a
    hours = []
    hours << 0.0
    hours += (0.5..10.0).step(0.5).to_a
  end

  def icon_tag(icon_name, options = {})
    icon_name += icon_name.include?('png') ? "" : ".png"
    options[:border] ||= 0
    image_tag("icons/#{icon_name}", options)
  end

  def render_sidebar
    content_for :sidebar do
      render :partial => "sidebar"
    end
  end
end

# mixing in RubyEnhancements-module
class Object
  include ObjectEnhancement # see /lib
end

class String
  include StringEnhancement # see /lib
end

class Time
  include TimeEnhancement # see /lib
end

class Date
  include TimeEnhancement # see /lib
end

class Float
  include FloatEnhancement # see /lib
end

class Array
  include ArrayEnhancement # see /lib
end
