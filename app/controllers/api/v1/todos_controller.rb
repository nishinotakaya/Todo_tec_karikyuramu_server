class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:update, :destroy]

  def index
    if params[:output_date]
      @todos = Todo.where(output_date: params[:output_date]).order(:sort)
    else
      @todos = Todo.order(:sort)
    end
    render json: @todos
  end

  def create
    existing_todo = Todo.find_by(copy_id: params[:todo][:copy_id], output_date: params[:todo][:output_date])

    if existing_todo
      render json: { error: "同じcopy_idとoutput_dateのレコードは既に存在します" }, status: :unprocessable_entity
    else
      @todo = Todo.new(todo_params)
      if @todo.save
        render json: @todo, status: :created
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @todo.update(todo_params)
      if @todo.copy_id.present?
        # output_dateとsortを除くフィールドを更新
        fields_to_update = todo_params.to_h.except('output_date', 'sort')
        Todo.where(copy_id: @todo.copy_id).where.not(id: @todo.id).update_all(fields_to_update)
      end
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
    params.require(:todo).permit(
      :content,
      :completed,
      :delete_flg,
      :sort,
      :sub_content,
      :output_date,
      :progress_rate,
      :start_date,
      :completion_date,
      :completion_date_actual,
      :copy_id
    )
  end 
end
