module TasksHelper
  def priority_selector(task)
    select("task_#{task.id}", :priority_id, Priority.find(:all).collect { |p| [p.name, p.id] }, {}, 
            {:style => "display: none;",
             :onchange => remote_function(:url => {:action => :update_priority, :id => task.id},
                                                   :complete => "$('task_#{task.id}_priority_id').toggle(); $('task_#{task.id}_priority').toggle();",
                                                   :with => "'priority_id=' + $('task_#{task.id}_priority_id').value")})
  end

  def priority_tag(task)
    content_tag(:p, {:onclick => "$('task_#{task.id}_priority').toggle(); $('task_#{task.id}_priority_id').toggle();",
                     :id => "task_#{task.id}_priority"}) do
      h(task.priority)
    end
  end
end
