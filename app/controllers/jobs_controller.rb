class JobsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: [:show, :apply, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index

  def index
    @jobs = policy_scope(Job)

    if params[:search].present?
      @jobs = @jobs.where("title LIKE ?", "%#{params[:search]}%")
    end
  
    if params[:sort] == "recent"
      @jobs = @jobs.order(created_at: :desc)
    end
  
    if params[:department_id].present?
      @jobs = @jobs.where(department_id: params[:department_id])
    end
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
      redirect_to jobs_path
    else
      flash[:alert] = "Failed to create job."
      render :new
    end
  end

  def apply
    authorize @job

    if current_user.user_jobs.where(job: @job).exists?
      flash[:alert] = "You have already applied for this job."
      redirect_to jobs_path and return
    end

    @user_job = current_user.user_jobs.new(job: @job)

    if @user_job.save
      resume_blob = current_user.resume.blob
      @user_job.resume.attach(resume_blob)

      ActionCable.server.broadcast("job_notification_#{@job.id}", { message: "Real Time Notification, #{current_user.name} applied for your job: #{@job.title}"} )

      JobMailer.application_confirmation(current_user, @job).deliver_later

      flash[:notice] = "Successfully applied for the job."
      redirect_to jobs_path
    else
      flash[:alert] = "Failed to apply for the job."
      redirect_to jobs_path
    end
  end

  def edit
    authorize @job
  end

  def update
    authorize @job

    if @job.update(job_params)
      redirect_to jobs_path, notice: 'Job was successfully updated.'
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
