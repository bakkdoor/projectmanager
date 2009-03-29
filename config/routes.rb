ActionController::Routing::Routes.draw do |map|

  map.all_tasks "/tasks/all", :controller => "tasks", :action => "all"
  map.all_worktimes "/worktimes/all", :controller => "worktimes", :action => "all"

  map.resources :projects,
                :collection => { :active => :get, :finished => :get } do |project|
    project.resources :tasks, :collection => { :tagged => :get }
    project.resources :worktimes, :collection => { :all => :get, :start => :post, :stop => :post }
  end

  map.resources :customers, :has_many => [:projects]

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.resources :users
  map.profile '/profile', :controller => 'profile', :action => 'index'

  map.resource :session

  # See how all your routes lay out with "rake routes"
  # Install the default routes as the lowest priority.

  map.root :controller => "home"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
