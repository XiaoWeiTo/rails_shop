class Admin::CategoriesController < Admin::BaseController
  def index
    @categories = Category.roots.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: :desc)

  end

  def new
    @category = Category.new
    @root_categories = Category.roots.order(id: :desc)
  end

  def create
    @category = Category.new(params.require(:category).permit!)
    if @category.save
      flash[:notice] = "保存成功"
      redirect_to admin_categories_path
    else
      @root_categories = Category.roots.order(id: :desc)
      render action: :new
    end
  end

  def edit
    @category = Category.find(params[:id])
    @root_categories = Category.roots
  end

  def update
    @category = Category.find(params[:id])

    if @category.update(params.require(:category).permit!)
      flash[:notice] = "修改成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "修改失败"
      @root_categories = Category.roots
      render action: :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    if @category.destroy
      flash[:notice] = "删除成功"
      redirect_to admin_categories_path
    else
      flash[:notice] = "删除失败"
      redirect_to admin_categories_path
    end
  end
end
