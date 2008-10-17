module WorktimesHelper
  def play_pause_button(project)
    if session[:new_worktime_id]
        link_to(icon_tag('clock_stop'),
                {:controller => :worktimes, :action => :stop, :project_id => project.id},
                :method => :post)
    else
      link_to(icon_tag('clock_play'),
              {:controller => :worktimes, :action => :start, :project_id => project.id},
              :method => :post)
    end
  end
end