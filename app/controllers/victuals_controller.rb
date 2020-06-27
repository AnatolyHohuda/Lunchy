class VictualsController < ApplicationController

  def index
    @victuals = Victual.order(:name).paginate(page: params[:page])
  end
 
  def show
    @victual = Victual.find(params[:id])
  end
 
  def new
    @victual = Victual.new
  end
 
  def edit
    @victual = Victual.find(params[:id])
  end
 
  def create
    @victual = Victual.new(victual_creating_params)
    if @victual.save
      @victual.change_categories(params[:victual][:category_ids])
      flash[:success] = "Victual successfuly added!"
      redirect_to @victual
    else
      @victual.errors.messages do |attr, msg|
        flash[attr] = msg
      end
      render 'new'
    end
  end
 
  def update
    @victual = Victual.find(params[:id])
    @victual.change_categories(params[:victual][:category_ids])
    if @victual.update(victual_params)
      flash[:success] = "Victual successfuly updated!"
      redirect_to @victual
    else
      @victual.errors.messages do |attr, msg|
        flash[attr] = msg
      end
      render 'edit'
    end
  end
 
  def destroy
    @victual = Victual.find(params[:id])
    @victual.destroy
 
    redirect_to victuals_path
  end
 
  private
    def victual_params
      params.require(:victual).permit(:id, :name, :price, category_ids: [])
    end
    def victual_creating_params
      params.require(:victual).permit(:id, :name, :price)
    end
end
