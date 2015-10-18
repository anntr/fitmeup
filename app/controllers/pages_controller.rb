class PagesController < ApplicationController
  skip_before_action :authorize
  def main
  end

  def about
  end
end
