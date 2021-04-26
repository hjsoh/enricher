module ApplicationHelper
  def list_active(classroom, url)
    if url.include?(classroom.id.to_s)
      'active'
    else
      nil
    end
  end

  def get_unread_announcements(user)
    if user.role == "teacher"
      announcements = user.announcements.order(created_at: :desc)
      #raise
      classrooms = user.classrooms
      classroom_announcements = []
      classrooms.each do |classroom|
        if !classroom.classroom_announcements.empty?
          classroom_announcements << classroom.classroom_announcements
        end
      end
      filtered_announcements = classroom_announcements.flatten
      unread_announcements = filtered_announcements.reject{ |announcement| announcement.created_at <= user.last_sign_in_at }
      # raise
    else
      #TODO
      'nothing'
    end

    if unread_announcements.length > 0
      content_tag(:span, "#{unread_announcements.length}", class: 'badge-primary')
    end
  end
end
