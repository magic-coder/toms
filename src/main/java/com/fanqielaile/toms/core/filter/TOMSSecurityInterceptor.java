package com.fanqielaile.toms.core.filter;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.fanqie.util.DateUtil;
import com.fanqielaile.toms.bo.ctrip.homestay.RequestBean;
import com.fanqielaile.toms.enums.ResultCode;
import com.fanqielaile.toms.exception.BusinessException;
import com.fanqielaile.toms.model.Company;
import com.fanqielaile.toms.util.CompanyCache;
import com.fanqielaile.toms.util.PassWordUtil;


public class TOMSSecurityInterceptor  implements HandlerInterceptor   {
	protected transient final Logger log  =  Logger.getLogger(this.getClass());
	
	@Override
	public boolean  preHandle(HttpServletRequest request,  HttpServletResponse response, 
			Object handler) throws Exception {
        request.setCharacterEncoding("UTF-8");
        //需要过滤的代码         
        String timestamp = request.getParameter("timestamp");
        String signature = request.getParameter("signature");
        String otaId = request.getParameter("otaId");
        log.info("请求拦截开始,请求参数为 ,timestamp:"+timestamp+";signature:"+signature+";otaId"+otaId);
        RequestBean qBean =  new RequestBean();
        qBean.setOtaId(otaId);
        qBean.setSignature(signature);
        qBean.setTimestamp(timestamp);
        Map<String,Object> requestMap  = new HashMap<>();
        
    
        if(checkApiRequest(qBean,requestMap)){
        //	filter.doFilter(servletRequest, servletResponse); 
        	return true;
        }else{
        	response.setContentType("application/json;charset=UTF-8");
        	response.getWriter().print(JSONObject.toJSON(requestMap));
        	return false;
        }
	}
	
	public boolean checkApiRequest(RequestBean qBean,Map<String,Object> requestMap){
		boolean sign = true;
		if(!StringUtils.isEmpty(qBean.getOtaId()) //参数不能为空
				 && !StringUtils.isEmpty(qBean.getSignature()) 
				 && !StringUtils.isEmpty(qBean.getTimestamp())){
			long time=0;
			Company company = new Company();
			try{
				 time = Long.valueOf(qBean.getTimestamp());
			} catch (NumberFormatException e) {
		    	setErrorInfo(requestMap, ResultCode.PARAM_ERROR.getMessage(),ResultCode.PARAM_ERROR.getCode());
		    	return sign;
			} 
			// 是否超时
			long starttmil =System.currentTimeMillis()-(5*DateUtil.MILLION_SECONDS_OF_MINUTE);
  			long endtmil =System.currentTimeMillis()+(5*DateUtil.MILLION_SECONDS_OF_MINUTE);

			if(time<=starttmil || time>=endtmil){ //请求超时
		    	sign =false;
		    	setErrorInfo(requestMap, ResultCode.TIME_OUT.getMessage(),ResultCode.TIME_OUT.getCode());
		    	//throw new BusinessException(ResultCode.TIME_OUT.getMessage(),ResultCode.TIME_OUT.getCode());
			}else{				
				try {//sign 是否合法
					company = CompanyCache.get(qBean.getOtaId());
					if(company != null){
						String key =company.getOtaId()+""+time+company.getUserAccount()+company.getUserPassword();
						log.info("获取的 key:"+key);
						String signature = PassWordUtil.getMd5Pwd(key);
						if(!signature.equals(qBean.getSignature())){
							setErrorInfo(requestMap, ResultCode.SIFNATURE_ERROR.getMessage(),ResultCode.SIFNATURE_ERROR.getCode());
							sign =false;
						}
					}else{
						setErrorInfo(requestMap, ResultCode.PARAM_ERROR.getMessage(),ResultCode.PARAM_ERROR.getCode());
						sign =false;
					}
				} catch (Exception e) {
					setErrorInfo(requestMap, ResultCode.SYSTEM_EXCEPTION.getMessage(),ResultCode.SYSTEM_EXCEPTION.getCode());
					sign =false;
					log.error("拦截系统异常!e"+e);
				}
			}
			
			//秘钥是不对
	    }else{
	    	setErrorInfo(requestMap, ResultCode.PARAM_ERROR.getMessage(),ResultCode.PARAM_ERROR.getCode());
	    	sign = false;
	    }
		log.debug(requestMap);
		return sign;
		
	}

	
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

	
	private void setErrorInfo(Map<String, Object> map,String msg,String code){
		map.put("resultCode", code);
		map.put("resultMessage", msg);
	}


}
