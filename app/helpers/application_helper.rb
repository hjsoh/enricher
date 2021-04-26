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
      #for parent
      #TODO
      'nothing'
    end

    if unread_announcements.length > 0
      content_tag(:span, "#{unread_announcements.length}", class: 'badge-primary')
    end
  end

  def get_unread_tickets(user)
    if user.role == "teacher"
      classrooms = user.classrooms
      classroom_tickets = []
      classrooms.each do |classroom|
        if !classroom.tickets.empty?
          classroom.tickets.each do |ticket|
            if ticket.status != "Completed"
              classroom_tickets << ticket
            end
          end
        end
      end
    end
    classroom_tickets = classroom_tickets.reject{ |ticket| ticket.created_at <= user.last_sign_in_at }

    if classroom_tickets.length > 0
      content_tag(:span, "#{classroom_tickets.length}", class: 'badge-primary')
    end
  end

  def get_unread_appointments(user)
    #for teacher
  end
end
