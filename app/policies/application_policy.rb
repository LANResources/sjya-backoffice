ApplicationPolicy = Struct.new(:user, :resource) do
  def index?
    false
  end

  def show?
    scope.where(:id => resource.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, resource.class)
  end
end

