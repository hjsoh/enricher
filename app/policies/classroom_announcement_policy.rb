class ClassroomAnnouncementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      ClassroomAnnouncement.all
    end
  end

  def show_chat?
    true
  end
end
