class Api::PerksController < ApplicationController

  def index
    # @events = Event.all
    # render json: @events
  end

  def show
    # @event = Event.find(params['id'])
    # render json: @event.to_json(include: :perks)
  end

  def update
    # @event = Event.find(params['id'])
    # p [params['session_token']]
    # @user = User.find_by(session_token: params['session_token'])
    # if(@user && @user.id == @event.owner_id)
    #   @event.update_attributes(event_params)
    #   @event.save
    #   render json: @event
    # elsif(@event.funds_raised < event_params['funds_raised'])
    #   @event.funds_raised = event_params['funds_raised']
    #   @event.save
    # end
  end

  def create
    @perk = Perk.new(perk_params)
    # check to see if perk's event is owned by user
    # @user = Perk.find_by(session_token: params['session_token'])
    # @event.owner_id = @user.id
    if @perk.save!
      render json: @perk
    else
      render json: {errors: @perk.errors.full_messages}, status: 422
    end
  end

  def destroy
    @perk = Perk.find(params['id'])
    # @user = User.find_by(session_token: params['session_token'])
    # if(@event.id == @user.id)
      render json: @perk.destroy
    # else
    #   render json: {errors: ['not your event!']}, status: 422
    # end
  end

  def perk_params
    params.permit(:title, :cost, :currency, :description, :claimed, :available,
    :delivery_date, :event_id, :img_src)
  end

end
