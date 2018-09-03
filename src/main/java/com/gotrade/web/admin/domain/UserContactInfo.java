package com.gotrade.web.admin.domain;

public class UserContactInfo {

	private String accNum;
	private String custID;
	private String email1;
	private String email2;
	private String areaCode1;
	private String areaCode2;
	private String phone1;
	private String phone2;

	public String getAccNum() {
		return accNum;
	}

	public void setAccNum(String accNum) {
		this.accNum = accNum;
	}

	public String getCustID() {
		return custID;
	}

	public void setCustID(String custID) {
		this.custID = custID;
	}

	public String getEmail1() {
		return email1;
	}

	public void setEmail1(String email1) {
		this.email1 = email1;
	}

	public String getEmail2() {
		return email2;
	}

	public void setEmail2(String email2) {
		this.email2 = email2;
	}

	public String getPhone1() {
		return phone1;
	}

	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}

	public String getPhone2() {
		return phone2;
	}

	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	
	public String getAreaCode1(){
		return areaCode1;
	}
	public void setAreaCode1(String areaCode1){
		this.areaCode1=areaCode1;
	}
	
	public String getAreaCode2(){
		return areaCode2;
	}
	public void setAreaCode2(String areaCode2){
		this.areaCode2=areaCode2;
	}

}
