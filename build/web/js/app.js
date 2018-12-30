/*
    Javascript of Index.jsp
*/

// context_path was declared in header.jsp

// Load more new book
$(".load-more").click(function (e) {
    e.preventDefault();
    var self = $(this);
    var start = $(this).closest(".card").find(".zoom").length;
    if (start < 4) {
        return;
    }
    var page = start / 4 + 1;
    var category = $(this).attr('cat_id');
    if (category) {
        var data = { "cat": category, "page": page };
    } else {
        var type = $(this).attr('mode');
        var data = { "mode": type, "page": page };
    }
    var text = "";
    $.ajax({
        type: "get",
        url: context_path + "/loadmore",
        data: data,
        dataType: "json",
        success: function (response) {
            response.forEach(book => {
                text += '<div class="card zoom mb-4">';
                text += '<img class="card-img-top" src="/book/images/book/' + book.slug + '.gif" alt="Card image cap" height="400px" onclick="viewBook(' + book.id + ')">';
                text += '<div class="card-body" onclick="viewBook(' + book.id + ')">';
                text += '<a href="/book/book.jsp?bookId=' + book.id + '">';
                text += '<h5 class="card-title">' + book.name + '</h5>';
                text += '</a>';
                text += '<p class="card-text text-muted">' + book.author + '</p>';
                text += '<p class="card-text"><b>' + book.price + 'đ</b></p>';
                text += '</div>';
                text += '<div class="card-footer text-center">';
                text += '<button class="btn btn-primary btn-sm" onclick="addCart(' + book.id + ')">';
                text += '<i class="fa fa-cart-plus"></i> Add to cart';
                text += '</button>';
                text += '<button class="btn btn-danger btn-sm" style="margin-left: 5px!important" onclick="addCartAndCheckout(' + book.id + ')">';
                text += '<i class="fa fa-cart-plus"></i> Buy it now';
                text += '</button>';
                text += '</div>';
                text += '</div>';
            });
            self.closest(".card").find(".card-deck").append(text);
        }
    });
    // $(this).closest(".card").find(".zoom")
    var tmp = $(this).closest(".card").find(".zoom").length - 1;
});
// Add cart
function addCart(book_id) {
    var id = book_id;
    $.ajax({
        type: "get",
        url: context_path + "/addToCart",
        data: { "id": id },
        dataType: "json",
        success: function (response) {
            var text = "";
            text += '<div class="card-body m-0 p-3">';
            text += '<div class="row">';
            text += '<div class="col-md-4">';
            text += '<img src="/book/images/book/' + response.slug + '.gif" width="100%">';
            text += '</div>';
            text += '<div class="col-md-8">';
            text += '<p class="card-title">' + response.name + "</p>";
            text += '<p class="card-text">' + response.price + "đ</p>";
            text += '</div>';
            text += '</div>';
            text += '</div>';
            $("#cart-body").append(text);
            var total = parseInt($("#cart-total").html()) + response.price;
            $("#cart-total").html(total);
            // Notification
            toastr.success("Book has been added to cart");
        },
        error: function (error) {
            toastr.error("Failed to add book to cart");
        }
    });
}

function addCartAndCheckout(book_id) {
    addCart(book_id);
    window.location.replace(context_path + "/cart.jsp");
}

// Load cart
$(document).ready(function () {
    $.ajax({
        type: "get",
        url: context_path + "/loadCart",
        dataType: "json",
        success: function (response) {
            var cart = response;
            var text = "";
            var total = 0;
            cart.forEach(book => {
                text += '<div class="card-body m-0 p-3">';
                text += '<div class="row">';
                text += '<div class="col-md-4">';
                text += '<img src="/book/images/book/' + book.slug + '.gif" width="100%">';
                text += '</div>';
                text += '<div class="col-md-8">';
                text += '<p class="card-title">' + book.name + "</p>";
                text += '<p class="card-text">' + book.price + "đ</p>";
                text += '</div>';
                text += '</div>';
                text += '</div>';
                total += book.price;
            })
            $("#cart-body").html(text);
            $("#cart-total").html(total);
        }
    });
});

// Show cart
$("#cart-icon").click(function (e) {
    e.preventDefault();
    $("#cart").toggle();
});

function addToFavorite(cat_id) {
    $.ajax({
        type: "post",
        url: context_path + "/favorite",
        data: { "cat_id": cat_id },
        success: function (response) {
            toastr.success("Added to your favorite");
            var target = "#favorite-button-" + cat_id;
            $(target).attr('class', 'btn btn-sm btn-success float-right');
            $(target).attr('onclick', "").unbind("click");
            $(target).html("<i class='fa fa-check'></i> Favorited");
        }
    });
}

/*
    Breadcrumb
*/
var path = window.location.pathname;
console.log(context_path);
path = path.replace(context_path + "/admin/", "");
path = path.replace(new RegExp('.jsp.*'), "");
if (path != "") {
    var breadcrumb = path.split("/");
    var breadcrumb_text = "";
    breadcrumb.forEach(bread => {
        breadcrumb_text += '<li class="breadcrumb-item active">' + bread + '</li>';
    })
    $("#breadcrumb").append(breadcrumb_text);
}

/*
    Realtime notification using pusher
    user_id variable was defined in header.jsp
*/

var channel = "new-favorite-book-" + user_id;

var pusher = new Pusher('bb415e34026b68357364', {
    cluster: 'ap1',
    forceTLS: true
});

var channel = pusher.subscribe(channel);
channel.bind('new-favorite-book', function (data) {
    toastr.success("Your favorite category has published a new book: " + data.name, { "timeOut": 15000 });
});


// Invoice update
function updateInvoice(id, status) {
    $.ajax({
        type: "post",
        url: context_path + "/invoice/update",
        data: { "invoice_id": id, "status": status },
        success: function (response) {
            toastr.success("Invoice updated!", {
                "positionClass": "toast-bottom-right",
            });
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        }
    });
}

/* 
    View book
*/

function viewBook(book_id) {
    window.location.href = context_path + "/book.jsp?bookId=" + book_id;
}


// Admin book 
function deleteBook(book_id) {
    $.ajax({
        type: "get",
        url: context_path + "/book/delete",
        data: { "id": book_id },
        dataType: "json",
        success: function (response) {
            toastr.success("Book has been deleted");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to delete book!");
        }
    });
}
function restoreBook(book_id) {
    $.ajax({
        type: "get",
        url: context_path + "/book/restore",
        data: { "id": book_id },
        dataType: "json",
        success: function (response) {
            toastr.success("Book has been restore");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to restore book!");
        }
    });
}

// Admin category
function deleteCategory(cat_id) {
    $.ajax({
        type: "get",
        url: context_path + "/category/delete",
        data: { "id": cat_id },
        dataType: "json",
        success: function (response) {
            toastr.success("Category has been deleted");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to delete book!");
        }
    });
}
function restoreCategory(cat_id) {
    $.ajax({
        type: "get",
        url: context_path + "/category/restore",
        data: { "id": cat_id },
        dataType: "json",
        success: function (response) {
            toastr.success("Category has been restore");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to restore category!");
        }
    });
}

// Import
function deleteImport(import_id) {
    $.ajax({
        type: "get",
        url: context_path + "/import/delete",
        data: { "id": import_id },
        dataType: "json",
        success: function (response) {
            toastr.success("Import has been deleted");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to delete import!");
        }
    });
}
function restoreImport(import_id) {
    $.ajax({
        type: "get",
        url: context_path + "/import/restore",
        data: { "id": import_id },
        dataType: "json",
        success: function (response) {
            toastr.success("Import has been restore");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to restore import!");
        }
    });
}



// User
function deleteUser(user_id) {
    $.ajax({
        type: "get",
        url: context_path + "/user/delete",
        data: { "id": user_id },
        dataType: "json",
        success: function (response) {
            toastr.success("User has been deleted");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to delete user!");
        }
    });
}
function restoreUser(user_id) {
    $.ajax({
        type: "get",
        url: context_path + "/user/restore",
        data: { "id": user_id },
        dataType: "json",
        success: function (response) {
            toastr.success("User has been restore");
            setTimeout(function () {
                window.location.reload();
            }, 1000);
        },
        error: function (error) {
            toastr.error("Failed to restore user!");
        }
    });
}