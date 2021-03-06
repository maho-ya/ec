module Admin
  class CategoriesController < ApplicationController
    def index
      @q = Category.ransack(params[:q])
      @q.sorts = 'id desc'
      @categories = @q.result(distinct: true).page(params[:page])
    end

    def show
      @category = Category.find(params[:id])
    end

    def new
      @category = Category.new
      @select_parent_id = Category.all
    end

    def create
      @category = Category.new(category_form_params)

      if @category.save
        redirect_to admin_categories_path, notice: Category.model_name.human + "「#{@category.name}」を登録しました。"
      else
        @select_parent_id = Category.all
        render :new
      end
    end

    def edit
      @category = Category.find(params[:id])
      @select_parent_id = Category.where.not(id: params[:id])
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_form_params)
        redirect_to admin_categories_url, notice: Category.model_name.human + "「#{@category.name}」を更新しました。"
      else
        @select_parent_id = Category.where.not(id: params[:id])
        render :edit
      end
    end

    def destroy
      category = Category.find_by(id: params[:id])
      if category.nil?
        redirect_index '削除に失敗しました。対象の' + Category.model_name.human + 'は存在しません。'
      elsif category.destroy
        redirect_index Category.model_name.human + "「#{category.name}」を削除しました。"
      else
        redirect_index '削除に失敗しました。' + fetch_errors(category)
      end
    end

    private

    def redirect_index(message)
      redirect_to admin_categories_url, notice: message
    end

    # def category_params
    #   params.require(:category).permit(:name, :parent_id, :display_start_datetime,
    #                                    :display_end_datetime).merge(is_divide_by_date_and_time: false)
    # end

    def category_form_params
      params.require(:category).permit(:name, :parent_id,
                                       :display_start_datetime_ymd, :display_start_datetime_hn,
                                       :display_end_datetime_ymd,
                                       :display_end_datetime_hn).merge(is_divide_by_date_and_time: true)
    end
  end
end
