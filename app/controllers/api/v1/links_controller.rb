class Api::V1::LinksController < ApplicationController
  def index
    @links = current_user.links
    render json: @links
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      render json: @link, status: 201
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def update
    @link = Link.find(params[:id])
    read = @link.read ? false : true
    if @link.update(read: read)
      HotReadsService.record_read(@link) if @link.read
      head :no_content
    else
      render json: @link.errors.full_messages, status: 500
    end
  end

  def top
    @hot_reads = HotReadsService.get_top_ten
    render json: @hot_reads
  end

  private

  def link_params
    params.permit(:title, :url, :read)
  end
end
