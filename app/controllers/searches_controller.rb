class SearchesController < ApplicationController
  before_action :set_q

  def index
    @results = @q.result.includes(:lend, :name).order(created_at: :desc)
  end

  private
  def set_q
    @q = Lend.ransack(params[:q])
  end
end
