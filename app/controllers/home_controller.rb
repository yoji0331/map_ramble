class HomeController < ApplicationController
  def index
    @my_map = current_my_map
  end
end
