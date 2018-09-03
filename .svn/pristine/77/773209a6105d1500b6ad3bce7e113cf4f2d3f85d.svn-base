package com.gotrade.web.admin.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gotrade.web.admin.dao.broker.UserDao;
import com.gotrade.web.admin.domain.UserContactInfo;
import com.gotrade.web.admin.service.UserContactService;

@Service
public class UserContactServiceImpl implements UserContactService {
	
	@Autowired
	private UserDao userDao;

	@Override
	public List<UserContactInfo> getWebContactInfoByAccNum(String[] accNums) {
		return userDao.getUserContactInfoListByAccNum(accNums);
	}

	@Override
	public int updateWebContactInfoByAccNum(String[] accNums, UserContactInfo userContactInfo) {
		return userDao.updateWebContactInfoByAccNum(accNums,userContactInfo);
		
	}

		@Override
	public int updateWebContactInfoByFile(UserContactInfo[] userContactInfos) {
		return userDao.updateWebContactInfoByFile(userContactInfos);
	}

}
