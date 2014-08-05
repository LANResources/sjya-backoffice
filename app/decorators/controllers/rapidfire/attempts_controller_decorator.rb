Rapidfire::AttemptsController.class_eval do
  private

  def scope_attempts
    @scopes = {}
    @scope_params = {}
    @attempts = Rapidfire::Attempt.includes(:user)
    if params[:for]
      @scopes[:for] = "for #{params[:for]}"
      @scope_params[:for] = params[:for]
      @attempts = @attempts.where "'#{params[:for]}' = ANY (completed_for)"
    end
    if params[:user] and User.exists?(params[:user])
      @scopes[:user] = "by #{User.find(params[:user]).full_name}"
      @scope_params[:user] = params[:user]
      @attempts = @attempts.where user_id: params[:user]
    end
    if params[:incomplete_match_data]
      @scopes[:incomplete_match_data] = 'with incomplete match data'
      @scope_params[:incomplete_match_data] = params[:incomplete_match_data]
      @attempts = @attempts.with_incomplete_match_data
    end
    @attempts = @attempts.order("#{sort_column} #{sort_direction('desc')}").page(params[:page]).per_page(20)
  end
end
