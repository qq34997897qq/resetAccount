package com.gotrade.web.admin.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gotrade.web.admin.domain.UserContactInfo;
import com.gotrade.web.admin.service.UserContactService;

@Controller
@RequestMapping(value = "/user")
public class UserContactController {

	@Autowired
	private UserContactService userContactService;

	private Workbook workbook = null;

	@RequestMapping(value = "/query_contact_info", method = RequestMethod.GET)
	public String getContactInfoForm() {
		return "query_contact_info";
	}

	@RequestMapping(value = "/update_contact_info", method = RequestMethod.GET)
	public String resetContactInfoForm() {
		return "update_contact_info";
	}

	@RequestMapping(value = "/query_contact_info/acc_num", method = RequestMethod.GET)
	@ResponseBody
	public List<UserContactInfo> getContactInfoByAccNum(@RequestParam(value = "account") String account) {
		List<UserContactInfo> list = new ArrayList<UserContactInfo>();
		list = userContactService.getWebContactInfoByAccNum(account.split(","));
		return list;

	}

	@RequestMapping(value = "/query_contact_info/file/acc_num", method = RequestMethod.POST)
	@ResponseBody
	public List<UserContactInfo> getContactInfoByFile(@RequestParam(value = "file") MultipartFile file)
			throws IOException {
		String[] accNums = this.parseAccNum(file.getInputStream());
		List<UserContactInfo> list = new ArrayList<UserContactInfo>();
		list = userContactService.getWebContactInfoByAccNum(accNums);
		return list;

	}

	@RequestMapping(value = "/update_contact_info/acc_num", method = RequestMethod.POST)
	@ResponseBody
	public List<UserContactInfo> updateContactInfoByAccNum(@RequestBody UserContactInfo userContactInfo) {
		String[] accNums = userContactInfo.getAccNum().split(",");
		userContactService.updateWebContactInfoByAccNum(accNums, userContactInfo);
		return userContactService.getWebContactInfoByAccNum(accNums);
	}

	@RequestMapping(value = "/update_contact_info/file/acc_num", method = RequestMethod.POST)
	@ResponseBody
	public List<UserContactInfo> updateContactInfoByAccNum(@RequestParam(value = "file") MultipartFile file)
			throws IOException {
		UserContactInfo[] userContactInfos = this.parseUserContact(file.getInputStream());
		String[] accNums = new String[userContactInfos.length];
		userContactService.updateWebContactInfoByFile(userContactInfos);
		for(int i = 0; i < userContactInfos.length; i++) {
			accNums[i] = userContactInfos[i].getAccNum();
		}
		return userContactService.getWebContactInfoByAccNum(accNums);
	}

	private String[] parseAccNum(InputStream inputStream) throws IOException {
		List<String> dataList = new ArrayList<String>();
		workbook = new XSSFWorkbook(inputStream);
		Sheet sheet = workbook.getSheetAt(0);
		Iterator<Row> rowIterator = sheet.iterator();
		while (rowIterator.hasNext()) {
			Row row = rowIterator.next();
			Iterator<Cell> cellIterator = row.cellIterator();
			while (cellIterator.hasNext()) {
				Cell cell = cellIterator.next();
				cell.setCellType(CellType.STRING);
				String element = cell.getStringCellValue();
				dataList.add(element);
				break;
			}
		}
		return dataList.toArray(new String[dataList.size()]);

	}

	private UserContactInfo[] parseUserContact(InputStream inputStream) throws IOException {
		List<UserContactInfo> dataList = new ArrayList<UserContactInfo>();
		workbook = new XSSFWorkbook(inputStream);
		Sheet sheet = workbook.getSheetAt(0);
		Iterator<Row> rowIterator = sheet.iterator();
		String[] arr = new String[10];
		UserContactInfo userContactInfo = null;
		while (rowIterator.hasNext()) {
			Row row = rowIterator.next();
			Iterator<Cell> cellIterator = row.cellIterator();
			int count = 0;
			while (cellIterator.hasNext()) {
				Cell cell = cellIterator.next();
				cell.setCellType(CellType.STRING);
				arr[count++] = cell.getStringCellValue();
			}
			userContactInfo = new UserContactInfo();
			userContactInfo.setAccNum(arr[0]);
			userContactInfo.setEmail1(arr[1]);
			userContactInfo.setEmail2(arr[2]);
			userContactInfo.setAreaCode1(arr[3]);
			userContactInfo.setPhone1(arr[4]);
			userContactInfo.setAreaCode2(arr[5]);
			userContactInfo.setPhone2(arr[6]);
			dataList.add(userContactInfo);

		}
		return dataList.toArray(new UserContactInfo[dataList.size()]);
	}
}
