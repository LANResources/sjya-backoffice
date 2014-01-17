class CacheController < ApplicationController
  def clear
    if current_user.administrator?
      Rails.cache.clear
      flash[:success] = "Successfully cleared application cache."
    end
    redirect_to root_url
  end
end
