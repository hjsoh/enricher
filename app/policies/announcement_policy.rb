class AnnouncementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.role == 'teacher'
        user.announcements
      elsif user.role == 'parent'
        user.student_announcements
      else
        Announcement.all
      end
    end
  end

  def new?
    true
  end

  def create?
    true
  end

  def show?
    true
  end

  def destroy?
    record.user == user # Only creator of announcement can delete it
  end
end
