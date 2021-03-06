<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="toms" uri="http://www.fanqielaile.com/jsp/tag/toms" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <title>客栈匹配列表</title>
  <%--  <link rel="stylesheet" type="text/css" href="/assets/css/normalize.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/jquery-ui-1.10.3.full.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/ace.min.css">
    <link rel="stylesheet" type="text/css" href="/assets/css/innRelation.css">--%>

  <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/userSet.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/jquery-ui-1.10.3.full.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/ace.min.css'/>">
  <link rel="stylesheet" type="text/css" href="<c:url value='/assets/css/innRelation.css'/>">
  <script src="<c:url value='/assets/js/jquery-2.0.3.min.js'/>"></script>
  <script src="<c:url value='/assets/layer/layer.js'/>"></script>
</head>
<body>
<div class="container">
  <ul class="nav-bar clearfix" style=" height: 63px;">
    <c:forEach items="${infoList}" var="o">
      <li <c:if test="${o.otaType.name()=='XC'}">class="background"</c:if>><a  href="<c:url value="/innMatch/match?otaInfoId=${o.otaInfoId}"/>">${o.otaInfo}</a></li>
    </c:forEach>
  </ul>

  <div class="widget-box widget-custom">
    <div class="widget-header widget-header-flat">
      <h4 class="smaller">携程旅行</h4>
    </div>

    <div class="widget-body">
      <div class="widget-main ">
        <form class="form-horizontal" role="form">
          <input name="otaInfoId" id="otaInfoId" type="hidden" value="${otaInfoId}">
          <input name="otaType" id="otaTypeId" type="hidden" value="XC">
          <div class="row">
            <div class="col-xs-4">
              <div class="form-group">
                <label class="col-xs-3 control-label no-padding-right" for="appKey">供应商编码(SupplierID)</label>
                <div class="col-xs-9">
                  <input type="text" id="appKey" name="appKey" placeholder="供应商编码" class="col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-3 control-label no-padding-right" for="appSecret">品牌编码(Brand)</label>
                <div class="col-xs-9">
                  <input type="text" id="appSecret" name="appSecret" placeholder="品牌编码" class="col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-3 control-label no-padding-right" for="userId">合作方编码(UserId)</label>
                <div class="col-xs-9">
                  <input type="text" id="userId" name="userId" placeholder="UserId" class="col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-3 control-label no-padding-right" for="xc_user_name">用户名</label>
                <div class="col-xs-9">
                  <input type="text" id="xc_user_name" name="appSecret" placeholder="用户名" class="col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-3 control-label no-padding-right" for="xc_password">密 码</label>
                <div class="col-xs-9">
                  <input type="text" id="xc_password" name="appSecret" placeholder="密 码" class="col-xs-12">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-3 control-label no-padding-right" >价格模式</label>
                <div class="col-xs-9">
                  <toms:usedPriceModel/><br>
                </div>
              </div>
              <div class="form-field-tips" id="error"></div>
            </div>
            <div class="col-xs-8">
              <div class="well">
                <h4 class="green smaller lighter">如何获取APP KEY</h4>
                联系携程获取对应的值
              </div>
            </div>
          </div>
          <div class="clearfix form-actions">
            <div class="col-xs-12">
              <button class="btn btn-info" f-url="<c:url value="/innMatch/match?otaInfoId=${otaInfoId}"/>" data-url="<c:url value="/innMatch/vetted.json"/>" id="sub-id" type="button"> <i class="icon-ok bigger-110"></i>
                验证
              </button>
              &nbsp; &nbsp; &nbsp;
              <button class="btn" type="reset"> <i class="icon-undo bigger-110"></i>
                重置
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
<script src="<c:url value='/assets/js/jquery-ui-1.10.3.full.min.js'/>"></script>
<script src="<c:url value='/js/match/vetted.js'/>"></script>

</body>
</html>