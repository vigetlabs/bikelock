class UtilityController < ApplicationController
  def index
  end

  def lock
    if Hardware.lock
      redirect_to root_url
    else
      error_flash
      redirect_to root_url
    end
  end

  def unlock
    if Hardware.unlock
      redirect_to root_url
    else
      error_flash
      redirect_to root_url
    end
  end

  private

  def error_flash
    flash[:error] = "The system is not responding"
  end
end
