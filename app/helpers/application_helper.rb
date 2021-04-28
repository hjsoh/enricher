module ApplicationHelper
  def list_active(classroom, url)
    if url.include?(classroom.id.to_s)
      'active'
    end
  end

  def get_unread_announcements(user)
    if user.role == "parent"
      # find announcements made to classrooms of current user
      announcements = user.student_announcements.order(created_at: :desc)
      unread_announcements = announcements.where('announcements.created_at > ?', user.last_sign_in_at)
      unread_announcements.length
    end
  end
end
