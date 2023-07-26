class Admin::ProductsController < Admin::BaseController
    before_action :get_product_by_id,only: [:edit,:update,:destroy]
    before_action :get_root_categories,except:[:index,:destroy]

    def index
        @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order(id: :desc)
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(params.require(:product).permit!)
        if @product.save
            p "ok"
            flash[:notice] = "保存成功"
            redirect_to admin_products_path
        else
            p "failure"
            render :new,status: :bad_request
        end
    end

    def edit

    end

    def update
        if @product.update(params.require(:product).permit!)
            flash[:notice] = "修改成功"
            redirect_to admin_products_path
        else
            render :edit,status: :bad_request
        end
    end

    def destroy
        if @product.destroy
            flash[:notice] = "删除成功"
            redirect_to admin_products_path
        else

            render :back,status: :bad_request
        end
    end

    private
    def get_product_by_id
        @product = Product.find(params[:id])
    end


    def get_root_categories
        @root_categories = Category.roots.order(id: :desc)
    end
end