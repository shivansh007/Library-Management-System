class MembersController < ApplicationController
  protect_from_forgery only: %i[update delete create]

  def index
    @members = Member.all
    render json: { message: 'All members', members: @members }, status: :ok
  end

  def show
    @member = Member.find(params[:id])
    render json: { message: 'Member loaded', member: @member }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def create
    Library.find(member_params[:library_id])
    member = Member.create(member_params)
    if member.save
      render json: { message: 'Created member', member: member }, status: :ok
    else
      render json: { message: member.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def update
    member = Member.find(params[:id])
    Library.find(member_params[:library_id])
    if member.update_attributes(member_params)
      render json: { message: 'Member updated', member: member }, status: :ok
    else
      render json: { message: member.errors }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  def destroy
    member = Member.find(params[:id])
    member.destroy
    render json: { message: 'Member deleted', member: nil }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Not found' }, status: :not_found
  end

  private
  
  def member_params
    params.require('member').permit(:name, :address, :phone, :is_male, :code, :validity_date, :is_author, :library_id)
  end
end
