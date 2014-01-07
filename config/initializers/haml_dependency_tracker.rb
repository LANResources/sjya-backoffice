ActiveSupport.on_load(:action_view) do
  ActiveSupport.on_load(:after_initialize) do
    require 'action_view/dependency_tracker'
    ActionView::DependencyTracker.register_tracker :haml, ActionView::DependencyTracker::ERBTracker
  end
end