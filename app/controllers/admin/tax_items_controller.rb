module Admin
  class TaxItemsController < ApplicationController
    def index
      @q = TaxItem.ransack(params[:q])
      @q.sorts = 'id desc'
      @tax_items = @q.result(distinct: true).page(params[:page])
    end

    def show
      @tax_item = TaxItem.find(params[:id])
    end

    def new
      @tax_item = TaxItem.new
      fetch_data_for_select
    end

    def create
      @tax_item = TaxItem.new(tax_item_params)

      if @tax_item.save
        redirect_to admin_tax_items_path, notice: TaxItem.model_name.human + "「#{@tax_item.name}」を登録しました。"
      else
        fetch_data_for_select
        render :new
      end
    end

    def edit
      @tax_item = TaxItem.find(params[:id])
      fetch_data_for_select
    end

    def update
      @tax_item = TaxItem.find(params[:id])
      if @tax_item.update(tax_item_params)
        redirect_to admin_tax_items_path, notice: TaxItem.model_name.human + "「#{@tax_item.name}」を更新しました。"
      else
        fetch_data_for_select
        render :edit
      end
    end

    def destroy
      tax_item = TaxItem.find_by(id: params[:id])
      if tax_item.nil?
        redirect_index '削除に失敗しました。対象の' + TaxItem.model_name.human + 'は存在しません。'
      elsif tax_item.destroy
        redirect_index TaxItem.model_name.human + "「#{tax_item.name}」を削除しました。"
      else
        redirect_index '削除に失敗しました。' + fetch_errors(tax_item)
      end
    end

    private

    def fetch_data_for_select
      @select_tax = TaxItem.select_from_enum(:tax)
    end

    def redirect_index(message)
      redirect_to admin_tax_items_url, notice: message
    end

    def tax_item_params
      params.require(:tax_item).permit(:name, :tax)
    end
  end
end
