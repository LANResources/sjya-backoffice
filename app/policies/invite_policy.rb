class InvitePolicy < ApplicationPolicy

  def create?
    user >= :organization_manager
  end

  def edit?
    update?
  end

  def update?
    user == resource
  end

  def destroy?
    create?
  end
end
