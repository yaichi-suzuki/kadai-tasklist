class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = '新規Taskを登録しました'
      redirect_to @task
    else
      flash.now[:danger] = '新規Taskの登録に失敗しました'
      render :new
    end
  end
  
  def edit
  end
  
  def update

    if @task.update(task_params)
      flash[:success] = 'Task内容を更新しました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task内容の更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = 'Taskを削除しました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content)
  end

end
