class UtilityController < ApplicationController
  def index
  end

  def lock
    if Hardware.lock
      flash[:notice] = "Succesfully locked"
    else
      flash[:error] = "The system is not responding"
    end

    redirect_to root_url
  end

  def unlock
    if Hardware.unlock
      flash[:notice] = "Succesfully unlocked"
    else
      flash[:error] = "The system is not responding"
    end

    redirect_to root_url
  end

end
