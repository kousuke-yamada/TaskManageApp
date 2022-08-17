class TasksController < ApplicationController
  before_action :set_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user
  before_action :correct_user
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    
    # buildメソッドは以下と意味同じ（エイリアス）
    # @task = Task.new(task_params)
    # @task.user_id = @user.id
    
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def index
    @tasks = @user.tasks.order(created_at: :desc)
  end
  
  def edit
  end
  
  def update
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user, @task)
    else
      render :edit
    end
  end
  
  def show
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    # userのインスタンス変数@userを予め設定するためのメソッド
    def set_user
      @user = User.find(params[:user_id])
    end
    
    def set_task
      unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_tasks_url @user
      end
    end
end
