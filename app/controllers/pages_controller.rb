class PagesController < ApplicationController
  def home
    render plain: "Hello"
  end
  def team
    render plain: "Meet the team"
  end
  def contact
    render plain: "Contact us"
  end
end
