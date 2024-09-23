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
    user.admin?
  end

  def update?
    create?
  end

  def destroy?
    create?
  end

  def apply?
    user.candidate? && user.applicants.find_by(job: @record).blank?
  end

  class Scope < ApplicationPolicy::Scope

    def resolve
      if user.admin?
        scope.includes([ :users, :department, :rich_text_description ])
      else
        scope.includes([ :department, :rich_text_description ]).active
      end
    end
  end
end
