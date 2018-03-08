class EventAssignmentSetsController < ApplicationController
  before_action :set_event_assignment_set, only: [:show, :edit, :update, :destroy]

  # GET /event_assignment_sets
  def index
    @event_assignment_sets = EventAssignmentSet.all
  end

  # GET /event_assignment_sets/1
  def show
  end

  # GET /event/1/event_assignment_sets/new
  def new
    authorize event
    redirect_to edit_event_path(event) if event.has_book_assignments?
    event.book_assignments = EventAssignmentSet.new(event: event)
    @event_assignment_set = event.book_assignments
  end

  # GET /event_assignment_sets/1/edit
  def edit
  end

  # POST /event_assignment_sets
  def create
    @event_assignment_set = EventAssignmentSet.new(event_assignment_set_params)

    if @event_assignment_set.save
      redirect_to @event_assignment_set, notice: 'Event assignment set was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /event_assignment_sets/1
  def update
    if @event_assignment_set.update(event_assignment_set_params)
      redirect_to @event_assignment_set, notice: 'Event assignment set was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /event_assignment_sets/1
  def destroy
    @event_assignment_set.destroy
    redirect_to event_assignment_sets_url, notice: 'Event assignment set was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_assignment_set
      @event_assignment_set = EventAssignmentSet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_assignment_set_params
      params.require(:event_assignment_set).permit(:event, :year, :books)
    end
end
