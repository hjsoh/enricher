module ApplicationHelper
  def list_active(classroom, url)
      if url.include?(classroom.id.to_s)
          'active'
      else
           nil
      end
  end
end
