class Admin::ProductImagesController < Admin::BaseController
    before_action :find_product

    def index
        @product_images = @product.product_images.page(params[:page] || 1).per_page(params[:per_page] || 5).order(weight: :desc)
    end

    def create
        @product_image = ProductImage.new(product_image_params)

        @product_image.product = @product

        if @product_image.save
            flash[:notice] = "上传成功"
            redirect_back(fallback_location: { action: :index, id: @product.id})
        else
            flash[:notice] = "上传失败"
            redirect_to :back,status: :bad_request
        end
    end

    def update
        @product_image = ProductImage.find(params[:id])
        if @product_image.update(weight:params[:product_image][:weight])
            flash[:notice] = "修改成功"
        else
            flash[:notice] = "修改失败"
        end
        redirect_back(fallback_location: { action: :index, id: @product.id})
    end

    def destroy
        @product_image = ProductImage.find(params[:id])
        if @product_image.destroy
            flash[:notice] = "删除成功"
        else
            flash[:notice] = "删除失败"
        end
        redirect_back(fallback_location: { action: :index, id: @product.id})
    end
    

    private
    def find_product
        @product = Product.find(params[:product_id])
    end

    def product_image_params
        params.require(:product_image).permit!
    end
end