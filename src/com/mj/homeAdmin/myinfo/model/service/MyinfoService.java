package com.mj.homeAdmin.myinfo.model.service;

import com.mj.homeAdmin.myinfo.vo.MyinfoVo;

public interface MyinfoService {

	  public abstract String checkPw(MyinfoVo vo)
		        throws Exception;
	  public abstract void signUp(MyinfoVo vo)
		        throws Exception;
		
}
