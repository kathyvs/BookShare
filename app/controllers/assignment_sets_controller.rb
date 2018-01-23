class AssignmentSetsController < ApplicationController
  #before_action :set_assignment_set, only: [:show, :edit, :update, :destroy]

  # GET /events/:event/:year/assignment_sets
  def index
    @book_assignments = BookAssignments.new(
      Book.all,
      AssignmentSet.where(event: event, year: year))
  end

  # GET /assignment_sets/1
  def show
  end

  # GET /assignment_sets/new
  def new
    @assignment_set = AssignmentSet.new
  end

  # GET /assignment_sets/1/edit
  def edit
  end

  # POST /assignment_sets
  def create
    @assignment_set = AssignmentSet.new(assignment_set_params)

    if @assignment_set.save
      redirect_to @assignment_set, notice: 'Assignment set was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /assignment_sets/1
  def update
    if @assignment_set.update(assignment_set_params)
      redirect_to @assignment_set, notice: 'Assignment set was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /assignment_sets/1
  def destroy
    @assignment_set.destroy
    redirect_to assignment_sets_url, notice: 'Assignment set was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment_set
      @assignment_set = AssignmentSet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def assignment_set_params
      params.require(:assignment_set).permit(:arriving, :leaving)
    end
end
