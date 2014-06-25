class Api::EventsController < ApplicationController

  def index
    @events = Event.all
    render json: @events
  end

  def show
    @event = Event.find(params['id'])
    render json: @event.to_json(include: :perks)
  end

  def update
    @event = Event.find(params['id'])
    p [params['session_token']]
    @user = User.find_by(session_token: params['session_token'])
    if(@user && @user.id == @event.owner_id)
      @event.update_attributes(event_params)
      @event.save
      render json: @event
    elsif(@event.funds_raised < event_params['funds_raised'])
      @event.funds_raised = event_params['funds_raised']
      @event.save
    end
  end

  def create
    @event = Event.new(event_params)
    @user = User.find_by(session_token: params['session_token'])
    @event.owner_id = @user.id
    if @event.save!
      render json: @event
    else
      render json: {errors: @event.errors.full_messages}, status: 422
    end
  end

  def destroy
    @event = Event.find(event_params)
    @user = User.find_by(session_token: params['session_token'])
    if(@event.id == @user.id)
      render json: @event.destroy
    else
      render json: {errors: ['not your event!']}, status: 422
    end
  end

  def event_params
    params.permit(:id, :owner_id, :category, :img_src, :title, :description,
    :funds_raised, :funds_goal, :start, :end, :place, :currency, :body)
  end

end
