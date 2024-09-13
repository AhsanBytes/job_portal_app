class JobPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def new?
    create?
  end

  def create?
    user.admin? || user.hr?
  end

  def update?
    user.admin? || user.hr?
  end

  def destroy?
    user.admin? || user.hr?
  end

  def show?
    user.admin? || user.hr? || user.candidate?
  end

  def apply?
    user.candidate?
  end

  class Scope < ApplicationPolicy::Scope

    def resolve
      if user.admin? || user.hr?
        scope.all
      else
        scope.where(active: true)
      end
    end
  end
end
