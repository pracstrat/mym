var server_base = "http://localhost:3000/";

function recreate_category_list(data) {
    var items = data.map(function(element) {
        return '<li><a href="#">' + element['name'] + '</a><a href="#" class="delete">Delete</a></li>';
    });
    
    $("#category_list").html(items.join(''));
    $("#category_list").listview('refresh');
}

$('#categories').on('pagebeforecreate',function(obj){
    $.getJSON(server_base + 'categories.json', function(data) {
        recreate_category_list(data);
    });
});

$('#add_category_form').submit(function(e) {
    e.preventDefault();
    $.post(server_base + 'categories.json', $('#add_category_form').serialize(), function(data) {
        recreate_category_list(data);
        $.mobile.changePage("#categories");
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
        $.each($.parseJSON(jqXHR['responseText']), function(key, val) {
           alert("Could not add a category for this reason: " + key + " " + val[0]);
        });
    })
    .always(function(jqXHR, textStatus, errorThrown) {
        $('#category_name').val("");
    })
    
    return false;
});
