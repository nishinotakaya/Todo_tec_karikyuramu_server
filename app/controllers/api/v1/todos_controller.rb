class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    @todos = Todo.order(:sort)
    render json: @todos
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.sort = Todo.maximum(:sort).to_i + 1
    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:content, :completed, :delete_flg, :sort, :sub_content, :output_date, :progress_rate, :start_date, :completion_date)
  end  
end
