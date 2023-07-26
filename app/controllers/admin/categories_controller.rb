class Admin::CategoriesController < Admin::BaseController
  before_action :get_category_by_id,only: [:edit,:update,:destroy]
  before_action :get_root_categories,except:[:index,:destroy]


  def index
    if params[:id].blank?
      @categories = Category.roots.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: :desc)
    else
      @category = Category.find(params[:id])
      @categories = @category.children.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: :desc)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params.require(:category).permit!)
    if @category.save
      flash[:notice] = "保存成功"
      redirect_to admin_categories_path
    else
      render action: :new,status: :bad_request
    end
  end

  def edit
  end

  def update

    if @category.update(params.require(:category).permit!)
      flash[:notice] = "修改成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "修改失败"
      render action: :edit,status: :bad_request
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "删除失败"
      render :back,status: :bad_request
    end
  end

  private
  def get_category_by_id
    @category = Category.find(params[:id])
  end

  def get_root_categories
    @root_categories = Category.roots.order(id: :desc)
  end
end
