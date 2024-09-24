class JobsController < ApplicationController
  before_action :set_job, only: [:apply, :edit, :update, :destroy]
  before_action :set_departments, only: [:create,:new, :edit, :index]
  before_action :set_skills, only: [:edit, :new]
  after_action :verify_authorized, except: :index

  def index
    @jobs = policy_scope(Job)

    if params[:search].present?
      @jobs = @jobs.search_by_title(params[:search])
    end
  
    @jobs = @jobs.order(created_at: :desc) if params[:sort] == "recent"
  
    if params[:department_id].present?
      @jobs = @jobs.where(department_id: params[:department_id])
    end
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
      flash[:alert] = @job.errors.full_messages.to_sentence
      redirect_to new_job_path
    end
  end

  def apply
    authorize @job
    @user_job = current_user.user_jobs.new(job: @job)

    respond_to do |format|
      if @user_job.save
        ActionCable.server.broadcast("job_notification", { message: "Real Time Notification, #{current_user.name} applied for your job: #{@job.title}"} )
        JobMailer.application_confirmation(current_user, @job).deliver_later

        format.turbo_stream
        format.html { redirect_to jobs_path, notice: "Successfully applied for the job." }
      else
        format.turbo_stream
        format.html { redirect_to jobs_path, alert: @user_job.errors.full_messages.to_sentence }
      end
    end
  end

  def edit
    authorize @job
  end

  def update
    authorize @job

    respond_to do |format|
      if @job.update(job_params)
        format.turbo_stream
        format.html { redirect_to jobs_path, notice: "Job was successfully updated." }
      else
        format.turbo_stream
        format.html { redirect_to jobs_path, alert: @user_job.errors.full_messages.to_sentence }
      end
    end
  end

  def destroy
    authorize @job
    if @job.destroy
      flash[:notice] = 'Job was successfully deleted.'
    else
      flash[:notice] = "Job was not deleted: #{ @job.errors.full_messages.to_sentence }"
    end
    redirect_to jobs_url
  end

  private

  def set_job
    @job = Job.find_by(id: params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :company, :work_space_type, :location, :lead_source, :active, :department_id, skill_ids: [])
  end

  def set_departments
    @departments = Department.limit(7)
  end

  def set_skills
    @skills = Skill.limit(7)
  end
end
