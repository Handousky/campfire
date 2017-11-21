class CategoriesController < ApplicationController
  def show
    @stories = Category.find(params[:id]).stories
  end
end
