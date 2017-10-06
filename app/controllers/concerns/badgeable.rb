module BadgeCreator
  
  def check_achievements(type)
    send((type + '_achievements').to_sym)
  end

  def create_badge(type, name)
    return if achievement_already_reached?(type)
    id = Achievement.find_by_identity(type).id
    current_user.badges.create(achievement_id: id)
    flash[:achievement] = name 
  end

  def achievement_already_reached?(type)
    current_user.achievements.exists?(identity: type) 
  end

  #This is where you create the custom achievement logic - each method corresponds to a controller
  #to do: relocate this section - to their own files/module?
  
  def task_achievements()
    #condition(s)
    task_count = current_user.tasks.count_completed(current_user)  
    #achievements
    create_badge('10 tasks', 'Complete 10 tasks')      if task_count >= 10
    create_badge('100 tasks', 'Complete 100 tasks')    if task_count >= 100
    create_badge('1000 tasks', 'Complete 1000 tasks')  if task_count >= 1000
  end
end