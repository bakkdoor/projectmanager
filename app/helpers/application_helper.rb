# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu_items
    menu_items = {
                  "Home" => :home, "Kunden" => :customers, "Projekte" => :projects,
                  "Aufgaben" => :tasks, "Arbeitszeiten" => :worktimes
                 }
  end
end
