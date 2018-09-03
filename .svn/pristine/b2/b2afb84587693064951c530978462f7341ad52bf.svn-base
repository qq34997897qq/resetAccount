package com.gotrade.web.admin.dao.broker;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.gotrade.web.admin.domain.UserContactInfo;

public interface UserDao {
	


	int updateUserContact(List<UserContactInfo> userContactList);

	List<UserContactInfo> getUserContactInfoListByAccNum(String[] accNums);

	int updateWebContactInfoByAccNum(@Param("accNums")String[] accNums, @Param("userContactInfo")UserContactInfo userContactInfo);

	int updateWebContactInfoByFile(@Param("userContactInfos")UserContactInfo[] c);
}
