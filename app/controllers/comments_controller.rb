class CommentsController < ApplicationController
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @recipe
    else
      redirect_to @recipe, alert: "Komentarz musi mieć od 2 do 300 znaków"
    end
  end


  def comment_params
    params.require(:comment).permit(:comment, :user_id)
  end
end