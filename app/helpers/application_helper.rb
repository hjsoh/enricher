module ApplicationHelper
    def list_active(classroom, url)
        if url.include?(classroom.id.to_s)
            'active'
        else
             nil
        end
    end

    def get_announcements(user)
      @user = user
      @announcements = @user.announcements.order(created_at: :desc)
      @classrooms = @user.classrooms
      @classroom_announcements = []
      @classrooms.each do |classroom|
        if !classroom.classroom_announcements.empty?
          @classroom_announcements << classroom.classroom_announcements
        end
      end
      @filtered_announcements = @classroom_announcements.flatten

      @unread_announcements = @filtered_announcements.reject{ |announcement| announcement.created_at <= @user.last_sign_in_at }
    end
end
