class IssueHistoriesController < ApplicationController
  protect_from_forgery only: %i[update delete create]

  def index
    @issue_histories = IssueHistory.all
    respond_to do |format|
      format.json { render json: { message: 'All issue histories', issue_histories: @issue_histories }, status: :ok }
      format.html
    end
  end

  def show
    @issue_history = IssueHistory.find(params[:id])
    render json: { message: 'Issue history loaded', issue_history: @issue_history }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def create
    Member.find(issuehistory_params[:member_id])
    Book.find(issuehistory_params[:book_id])
    issue_history = IssueHistory.create(issuehistory_params)
    if issue_history.save
      render json: { message: 'Created issue history', issue_history: issue_history }, status: :ok
    else
      render json: { message: issue_history.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def update
    issue_history = IssueHistory.find(params[:id])
    Member.find(issuehistory_params[:member_id])
    Book.find(issuehistory_params[:book_id])
    if issue_history.update_attributes(issuehistory_params)
      render json: { message: 'Issue history updated', issue_history: issue_history }, status: :ok
    else
      render json: { message: issue_history.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def destroy
    issue_history = IssueHistory.find(params[:id])
    issue_history.destroy
    render json: { message: 'Issue history deleted', issue_history: nil }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  private

  def issuehistory_params
    params.require('issue_history').permit(:issue_type, :issue_date, :return_date, :member_id, :book_id)
  end
end
