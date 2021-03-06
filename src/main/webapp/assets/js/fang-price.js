$('#from_datepicker').change(function(){
	var obj = $("#fangPriceDetailId")
	var url = obj.attr("value")+"?v="+new Date().getTime();
	var innId = obj.attr("inn_id");
	var otaInfoId = obj.attr("ota_info_id");
	var date = $(this).val();
	$('#to_datepicker').val( TC.plusDate(date, '30', 'd', 'yyyy-MM-dd') );
	var startDate = $('#from_datepicker').val();
	var endDate = $('#to_datepicker').val();
	var postData = {'startDate': startDate, 'endDate': endDate, 'innId': innId, 'otaInfoId': otaInfoId};

	window.location.href = url+"&startDate="+startDate+"&endDate="+endDate+"&innId="+innId+"&otaInfoId="+otaInfoId;
	/*$.ajax({
		type:'POST',
		data: postData,
		url:url,
		dataType:'html',
		success:function(data){
			$("#roomTypeContainerId").empty();
			$("#roomTypeContainerId").html(data);
		}
	})*/
})
//上一月
$('#prevM').on('click',function(){
	var date = $('#from_datepicker').val();
	$('#from_datepicker').val( TC.plusDate(date, '-1', 'M', 'yyyy-MM-dd') ).change();
})
// 下一月
$('#nextM').on('click',function(){
	var date = $('#from_datepicker').val();
	$('#from_datepicker').val( TC.plusDate(date, '1', 'M', 'yyyy-MM-dd') ).change();
})

// datepicker
$( "#from_datepicker, #to_datepicker" ).datepicker({
	showOtherMonths: true,
	selectOtherMonths: true,
	dateFormat: 'yy-mm-dd',
	maxDate: new Date()
});
$.datepicker.regional['zh-CN'] = {
	closeText: '关闭',
	prevText: '<上月',
	nextText: '下月>',
	currentText: '今天',
	monthNames: ['一月','二月','三月','四月','五月','六月',
		'七月','八月','九月','十月','十一月','十二月'],
	monthNamesShort: ['一','二','三','四','五','六',
		'七','八','九','十','十一','十二'],
	dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],
	dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],
	dayNamesMin: ['日','一','二','三','四','五','六'],
	weekHeader: '周',
	dateFormat: 'yy-mm-dd',
	firstDay: 1,
	isRTL: false,
	showMonthAfterYear: true,
	yearSuffix: '年'};
$.datepicker.setDefaults($.datepicker.regional['zh-CN']);
function setSize(){
	var baseWidth = $(window).width()-210;
	$('.main-content').width( baseWidth );
	$('.table-right').width(baseWidth-130);
}
setSize();
$(window).on('resize', setSize);