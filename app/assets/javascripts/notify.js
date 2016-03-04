$(".email_subscribe").bind('change', function(){
    $.ajax({
        url: '/notifications/'+this.value+'/subscribe_via_email',
        type: 'POST',
        data: {"email_subscribed": this.checked}
    });
});