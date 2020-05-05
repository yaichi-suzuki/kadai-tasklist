class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :show, :update, :destroy]
  
  
  def index
    @tasks = current_user.tasks.order(id: :desc)
  end

  def show
    unless current_user[:id] == @task[:user_id]
      flash[:danger] = 'ログイン中のユーザが、タスクを登録したユーザと一致しません'
      redirect_to '/'
    end
  end
  
  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    
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

    if current_user[:id] == @task[:user_id]
      if @task.update(task_params)
        flash[:success] = 'Task内容を更新しました'
        redirect_to @task
      else
        flash.now[:danger] = 'Task内容の更新に失敗しました'
        render :edit
      end
    else
      flash.now[:danger] = 'ログイン中のユーザが、タスクを登録したユーザと一致しません'
      render :edit
    end
  end
  
  def destroy
    
    if current_user[:id] == @task[:user_id]
      @task.destroy
    
      flash[:success] = 'Taskを削除しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'ログイン中のユーザが、タスクを登録したユーザと一致しません'
      render :show
    end
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
