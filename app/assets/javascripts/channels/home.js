function noticeUp(obj,top,time) {
    // https://stackoverflow.com/questions/6737067/jquery-setinterval-too-fast-when-coming-from-another-tab
    $(obj).stop(true, true).animate({ marginTop: top },
        time,
        function () {
            $(this).css({marginTop:"0"}).find(":first").appendTo(this);
        });
}