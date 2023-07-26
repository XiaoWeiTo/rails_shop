class Admin::ProductImagesController < Admin::BaseController
    before_action :find_product

    def index
        @product_images = @product.product_images.order(weight: :asc)
    end

    def create
        @product_image = ProductImage.new(product_image_params)

        @product_image.product = @product

        if @product_image.save
            flash[:notice] = "上传成功"
            render :index
        else
            flash[:notice] = "上传失败"
            render action: :index,status: :bad_request
        end
    end

    def destroy

    end

    private
    def find_product
        @product = Product.find(params[:product_id])
    end

    def product_image_params
        params.require(:product_image).permit!
    end
end