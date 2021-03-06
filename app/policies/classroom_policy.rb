class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin == true
        scope.all
      elsif user.role == "teacher"
        user.classrooms.where(is_active: true)
        # scope.where(user: user)
      elsif user.role == 'parent'
        user.student_classrooms.where(is_active: true)
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
    record.user == user || record.parents.any? { |parent| parent == user }
  end

  def edit?
    true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def roster?
    true
  end

  def chatrooms?
    # record == classroom instance
    # user == current_user
    # only allow if all classrooms belongs to the current_user
    # and the current_user is a teacher or the parent of the classroom
    # record.all? do |classroom|
    true
    # classroom.user == user || classroom.students.any? { |student| student == user }
  end

  def show_chat?
    if user.role == 'teacher'
      user.classrooms.include? record
    else
      user.student_classrooms.include? record
    end
  end
end
