$(document).ready(() => {
    console.log("home load")
    $(document).on('click','.add-to-cart-btn', function (event) {
        console.log("button")
        event.preventDefault();

        let amount = $('input[name="amount"]')
        let prog = this.querySelector('i')
        console.log("href", event.target.href)
        if (amount.length > 0 && parseInt(amount.val()) <= 0) {
            alert("购买数量至少为1");
            return false;
        }

        const token = document.getElementsByName(
            "csrf-token"
        )[0].content;
        $.ajax({
            headers: {
                "X-CSRF-Token": token
            },
            url: event.target.href,
            method: 'post',
            dataType: 'html',
            contentType: 'application/json',
            data: JSON.stringify({ product_id: $(this).data('product-id'), amount: amount.val() ? amount.val() : 0 }),
            beforeSend: () => {
                // alert("beforeSend")
                if (!prog.classList.contains('fa-spin')) {
                    prog.classList.add('fa-spin');
                }
                prog.style.display = "block";
            },
            success: data => {
                // alert("success")
                console.log("success", data)
                if ($("#shopping_cart_modal").length > 0) {
                    $("#shopping_cart_modal").remove();
                }
                $('body').append(data);
                $('#shopping_cart_modal').modal('show');
            },
            error: error => {
                // alert("error");
                console.log("error", error);
            },
            complete: () => {
                // alert("complete")
                prog.style.display = "none";
            }
        })
    })
})