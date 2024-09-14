class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index

  def index
    @jobs = policy_scope(Job)
  end

  def show
    authorize @job
  end

  def new
    @job = Job.new
    authorize @job
  end

  def create
    @job = Job.new(job_params)
    @job.creator_id = current_user.id
    authorize @job

    if @job.save
      flash[:notice] = "Job successfully created."
      redirect_to @job
    else
      flash[:alert] = "Failed to create job."
      render :new
    end
  end

  def edit
    authorize @job
  end

  def update
    authorize @job

    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @job
    @job.destroy
    redirect_to jobs_url, notice: 'Job was successfully deleted.'
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :company, :work_space_type, :location, :lead_source, :active, :department_id, skill_ids: [])
  end
end
