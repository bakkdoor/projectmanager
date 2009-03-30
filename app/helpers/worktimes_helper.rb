module WorktimesHelper
  def play_pause_button(project)
    if session[:new_worktime_id]
        link_to("#{icon_tag('clock_stop')} #{t('worktime.timer.end')}",
                {:controller => :worktimes, :action => :stop, :project_id => project.id},
                :method => :post, :title => t('worktime.timer.end'), :class => "action_link")
    else
      link_to("#{icon_tag('clock_play')} #{t('worktimer.timer.start')}",
              {:controller => :worktimes, :action => :start, :project_id => project.id},
              :method => :post, :title => t('worktime.timer.start'), :class => "action_link")
    end
  end

  def play_pause_button_remote(project)
    if session[:new_worktime_id]
        link_to_remote("#{icon_tag('clock_stop')} #{t('worktime.timer.end')}",
                :url => {:controller => :worktimes, :action => :stop, :project_id => project.id},
                :method => :post,
                :html => { :title => t('worktime.timer.end'), :class => "action_link" })
    else
      link_to_remote("#{icon_tag('clock_play')} #{t('worktime.timer.start')}",
              :url => {:controller => :worktimes, :action => :start, :project_id => project.id},
              :method => :post,
              :html => { :title => t('worktime.timer.start'), :class => "action_link" })
    end
  end

end
