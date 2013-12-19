class DocumentPolicy < ApplicationPolicy
  self::Scope = Struct.new(:user, :scope) do
    def resolve
      if user >= :site_manager
        scope.all
      else
        scope.where(measurement_data: false)
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def download?
    show?
  end

  def new?
    true
  end

  def create?
    true
  end

  def edit?
    update?
  end

  def update?
    user == resource.user || user >= :site_manager
  end

  def destroy?
    update?
  end

  def permitted_attributes
    attrs = [:title, :item, :tag_list]
    attrs << :measurement_data if user >= :site_manager
    attrs
  end
end
