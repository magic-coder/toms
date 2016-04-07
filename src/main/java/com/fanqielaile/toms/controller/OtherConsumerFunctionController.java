package com.fanqielaile.toms.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;
import com.fanqie.util.JacksonUtil;
import com.fanqielaile.toms.dto.OtherConsumerInfoDto;
import com.fanqielaile.toms.model.Result;
import com.fanqielaile.toms.model.UserInfo;
import com.fanqielaile.toms.service.IOtherConsumerInfoService;
import com.fanqielaile.toms.support.tag.AuthorizeTagConsumer;
import com.fanqielaile.toms.support.util.Constants;
import com.fanqielaile.toms.support.util.JsonModel;
import org.apache.commons.collections.CollectionUtils;
import org.apache.log4j.Logger;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import java.util.Collections;
import java.util.List;

/**
 * DESC :
 * @author : 番茄木-ZLin
 * @data : 2016/3/25
 * @version: v1.0.0
 */
@Controller
@RequestMapping("/personality")
public class OtherConsumerFunctionController  extends BaseController {
    private static  final Logger log = Logger.getLogger(OtherConsumerFunctionController.class);
    @Resource
    private IOtherConsumerInfoService otherConsumerInfoService;

    @RequestMapping("/otherConsumer")
    public String orderExport(Model model){
        UserInfo currentUser = getCurrentUser();
        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ServletContext context = webApplicationContext.getServletContext();
        String contextPath = context.getContextPath();
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        AuthorizeTagConsumer authorizeTagConsumer = new AuthorizeTagConsumer();
        boolean b = authorizeTagConsumer.isAllow(contextPath, "/personality/otherConsumer", "GEI", authentication);
        if (b && currentUser!=null){
            List<OtherConsumerInfoDto> otherConsumerList = otherConsumerInfoService.findOtherConsumerInfo(currentUser.getCompanyId(),null);
            model.addAttribute(Constants.DATA,otherConsumerList);
        }else {
            return "/other_consumer/info_error";
        }
        return "/other_consumer/info";
    }

    @RequestMapping("/editView")
    @ResponseBody
    public Object editView(Model model,String consumerInfoId){
        JsonModel jsonModel = new JsonModel();
        UserInfo currentUser = getCurrentUser();
        List<OtherConsumerInfoDto> otherConsumerList = otherConsumerInfoService.findOtherConsumerInfo(currentUser.getCompanyId(),consumerInfoId);
        model.addAttribute(Constants.DATA,otherConsumerList);
        model.addAttribute(Constants.STATUS, Constants.SUCCESS);
        jsonModel.put(Constants.DATA, otherConsumerList.get(0));
        jsonModel.put(Constants.STATUS, Constants.SUCCESS);
        return  jsonModel;
    }

    @RequestMapping("/updateConsumerInfo")
    @ResponseBody
    public Object updateView(String json){
        JsonModel jsonModel = new JsonModel();
        UserInfo currentUser = getCurrentUser();
        OtherConsumerInfoDto priceRecordJsonBeans =  JSON.parseObject(json, new TypeReference<OtherConsumerInfoDto>() {});
        otherConsumerInfoService.updateOtherConsumerInfo(priceRecordJsonBeans, currentUser);
        jsonModel.put(Constants.STATUS, Constants.SUCCESS);
        return  jsonModel;
    }
    @RequestMapping("/addConsumerInfo")
    @ResponseBody
    public Object addConsumerInfo(String json){
        JsonModel jsonModel = new JsonModel();
        UserInfo currentUser = getCurrentUser();
        OtherConsumerInfoDto priceRecordJsonBeans =  JSON.parseObject(json, new TypeReference<OtherConsumerInfoDto>() {});
        priceRecordJsonBeans.setCompanyId(currentUser.getCompanyId());
        Result result = otherConsumerInfoService.saveOtherConsumerInfo(priceRecordJsonBeans, currentUser);
        jsonModel.put(Constants.STATUS, result.getStatus());
        jsonModel.put(Constants.MESSAGE, result.getMessage());
        return  jsonModel;
    }
    @RequestMapping("/delete")
    @ResponseBody
    public Object delete(String consumerInfoId){
        JsonModel jsonModel = new JsonModel();
        try {
            otherConsumerInfoService.deleteOtherConsumerInfo(consumerInfoId);
            jsonModel.put(Constants.STATUS, Constants.SUCCESS200);
        } catch (Exception e) {
            log.error("删除其他消费异常",e);
            jsonModel.put(Constants.STATUS, Constants.ERROR400);
            jsonModel.put(Constants.MESSAGE, e);
        }

        return  jsonModel;
    }

}
