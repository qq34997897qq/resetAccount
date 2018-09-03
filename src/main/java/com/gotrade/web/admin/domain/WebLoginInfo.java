package com.gotrade.web.admin.domain;

import java.util.Date;

public class WebLoginInfo {

	private String accNum;
	private String loginName;
	private Integer loginAttempt;
	private String firstLogin;
	private String blockLogin;
	private Date lastChangePwdTime;
	private String password;

	public String getAccNum() {
		return accNum;
	}

	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public Integer getLoginAttempt() {
		return loginAttempt;
	}

	public void setLoginAttempt(Integer loginAttempt) {
		this.loginAttempt = loginAttempt;
	}

	public String getFirstLogin() {
		return firstLogin;
	}

	public void setFirstLogin(String firstLogin) {
		this.firstLogin = firstLogin;
	}

	public String getBlockLogin() {
		return blockLogin;
	}

	public void setBlockLogin(String blockLogin) {
		this.blockLogin = blockLogin;
	}

	public Date getLastChangePwdTime() {
		return lastChangePwdTime;
	}

	public void setLastChangePwdTime(Date lastChangePwdTime) {
		this.lastChangePwdTime = lastChangePwdTime;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
