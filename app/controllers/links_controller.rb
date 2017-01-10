class LinksController < ApplicationController
  def index
    @hot_links = Link.hot
    @hot_reads = HotReadsService.get_top_ten
    @user_links = current_user.links if logged_in?
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:success] = 'Link Successfully Updated'
      redirect_to root_path
    else
      flash.now[:danger] = @link.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    link = Link.find(params[:id])
    link.destroy
    flash[:success] = 'Link Successfully Deleted'
    redirect_to root_path
  end

  private
    def link_params
      params.require(:link).permit(:url, :title)
    end
end
