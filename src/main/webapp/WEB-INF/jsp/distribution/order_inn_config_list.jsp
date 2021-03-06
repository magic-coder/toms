
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="toms" uri="http://www.fanqielaile.com/jsp/tag/toms" %>
<head>
    <title>客栈接单设置</title>
    <script src="<c:url value='/assets/js/jquery-2.0.3.min.js'/>"></script>
    <script src="<c:url value='/assets/layer/layer.js'/>"></script>
    <link href="<c:url value='/assets/css/pages.css'/>" rel="stylesheet"/>
</head>
</head>
<div class="page-content">
    <c:set value="${pagination}" var="page"/>
    <div class="row">
        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <div class="row">
                <div class="col-xs-12">
                    <h3 class="header smaller lighter blue">客栈接单设置</h3>
                    <div class="table-header" style="background-color:beige">
                        <span style="text-align: center;color:#393939" >
                        <span class="blue-order"> 自</span>：系统自动执行确认      <span class="red-order">手 </span>：人工手动执行确认
                        <span class="rosybrown-order"> 默认接单机制：系统自动确认接单</span>  </span>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main">
                            <form class="form-search" action="<c:url value="/distribution/orderConfig"/>" method="post">
                                <input type="hidden" id="pageId" name="page" value="${page.page}"/>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-8">
                                        <div class="input-group">
                                            <select name="innLabelId" >
                                                <option value="" selected>客栈分类</option>
                                                <c:if test="${not empty labels}">
                                                    <c:forEach items="${labels}" var="l">
                                                        <option <c:if test="${innLabel == l.id}">selected</c:if>
                                                                value="${l.id}">${l.labelName}</option>
                                                    </c:forEach>
                                                </c:if>
                                            </select> &nbsp;
                                            <input type="text" value="${keywords}" name="keywords" class="form-control search-query" style="width: 250px;" placeholder="请输入关键字、客栈名称"/>
                                            &nbsp;
										    <button type="submit" class="btn btn-purple btn-sm">
                                                Search
                                                <i class="icon-search icon-on-right bigger-110"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table id="sample-table-2" class="table table-striped table-bordered table-hover">
                            <thead style="font-size: 14px;">
                            <tr>
                                <th>客栈名称</th>
                                <th width="200">
                                   客栈分类
                                </th>
                                <c:forEach items="${otaList}" var="ota">
                                    <th>${ota.otaInfo}</th>
                                </c:forEach>
                                <th>操作</th>
                            </tr>
                            </thead>

                            <tbody class="table-data" style="font-size: 14px;">
                            <c:if test="${not empty orderConfigDtoList}">
                                <c:forEach items="${orderConfigDtoList}" var="d">
                                    <tr>
                                        <td>${d.innName}</td>
                                        <td>${d.labelName}</td>
                                        <c:forEach items="${d.value}" var="v">
                                            <c:if test="${v eq '手动'}">
                                                <td><span class="red-order">${v}</span></td>
                                            </c:if><c:if test="${v eq '自动'}">
                                                <td><span class="blue-order">${v}</span></td>
                                            </c:if>
                                        </c:forEach>
                                        <td>
                                            <div class="visible-md visible-lg hidden-sm hidden-xs action-buttons">
                                                <a>
                                                <i class="icon-pencil bigger-130 order-config-detail" data-url="<c:url value="/distribution/ajax/orderConfigDetail?innId="/>${d.innId}"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:if>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${page.pageCount>1}">
            <toms:page linkUrl="/distribution/orderConfig"  pagerDecorator="${pageDecorator}"/>
        </c:if>
        <c:if test="${empty orderConfigDtoList}">
            <div class="alert alert-danger center">
                没有数据,请筛选条件
            </div>
        </c:if>
    </div>
    <!-- /.col -->
</div>
<!-- /.row -->
<script>
    $('.order-config-detail').on('click', function () {
        var url = $(this).attr('data-url');
         $.ajax({
         type:'POST',
         url:url,
         dataType:'html',
         success:function(data){
         layer.open({
         title:"接单设置",
         type: 1,
         shift: 1,
         area: ['516px', '400px'],
         shadeClose: true, //开启遮罩关闭
         content: data
         });
         },error:function(data){
         alert(data);
         }
         })
    });
    /*$('.inn-label').on('change', function () {
        $("#pageId").attr("value", 1);
        $('.form-page').submit();
    });*/
    //分页方法
    function page(page) {
        $("#pageId").attr("value", page);
        $('.form-search').submit();
    };
    $(".btn-sm").bind("click",function(){
        $("#pageId").attr("value", 1);
        $('.form-search').submit();
    })
</script>

