package com.gotrade.web.admin.controller;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.gotrade.web.admin.domain.WebLoginInfo;
import com.gotrade.web.admin.service.WebLoginService;

@Controller
@RequestMapping(value = "/weblogin")
public class WebLoginController {

	@Autowired
	private WebLoginService webLoginService;

	private Workbook workbook = null;

	@RequestMapping(value = "/query_login_info", method = RequestMethod.GET)
	public String getLoginInfoForm() {
		return "query_login_info";
	}

	@RequestMapping(value = "/update_login_info", method = RequestMethod.GET)
	public String updateLoginInfoForm() {
		return "update_login_info";
	}

	@RequestMapping(value = "/query_login_info/acc_num", method = RequestMethod.GET)
	@ResponseBody
	public List<WebLoginInfo> getLoginInfoByAccNum(@RequestParam(value = "account") String account) {
		List<WebLoginInfo> list = new ArrayList<WebLoginInfo>();
		list = webLoginService.getWebLoginInfoListByAccNum(account.split(","));
		return list;
	}

	@RequestMapping(value = "/query_login_info/login_name", method = RequestMethod.GET)
	@ResponseBody
	public List<WebLoginInfo> getLoginInfoByLoginName(@RequestParam(value = "account") String account) {
		List<WebLoginInfo> list = new ArrayList<WebLoginInfo>();
		list = webLoginService.getWebLoginInfoListByLoginName(account.split(","));
		return list;
	}

	@RequestMapping(value = "/query_login_info/file/acc_num", method = RequestMethod.POST)
	@ResponseBody
	public List<WebLoginInfo> getLoginInfoByAccNum(@RequestParam(value = "file") MultipartFile file) {
		List<WebLoginInfo> list = new ArrayList<WebLoginInfo>();
		try {
			list = webLoginService.getWebLoginInfoListByAccNum(this.parse(file.getInputStream()));
		} catch (IOException e) {
		}
		return list;
	}

	@RequestMapping(value = "/query_login_info/file/login_name", method = RequestMethod.POST)
	@ResponseBody
	public List<WebLoginInfo> getLoginInfoByLoginName(Model model, @RequestParam(value = "file") MultipartFile file) {
		List<WebLoginInfo> list = new ArrayList<WebLoginInfo>();
		try {
			list = webLoginService.getWebLoginInfoListByLoginName(this.parse(file.getInputStream()));
		} catch (IOException e) {
		}
		return list;
	}

	@RequestMapping(value = "/update_login_info/login_name", method = RequestMethod.POST)
	@ResponseBody
	public List<WebLoginInfo> updateWebLoginInfoByLoignName(@RequestBody WebLoginInfo webLoginInfo) {
		String[] loginNames = webLoginInfo.getLoginName().split(",");
		webLoginService.updateWebLoginInfoByLoignName(loginNames, webLoginInfo);
		return webLoginService.getWebLoginInfoListByLoginName(loginNames);
	}

	@RequestMapping(value = "/update_login_info/acc_num", method = RequestMethod.POST)
	@ResponseBody
	public List<WebLoginInfo> updateWebLoginInfoByAccNum(@RequestBody WebLoginInfo webLoginInfo) {
		String[] accNums = webLoginInfo.getAccNum().split(",");
		webLoginService.updateWebLoginInfoByAccNum(accNums, webLoginInfo);
		return webLoginService.getWebLoginInfoListByAccNum(accNums);

	}

	@RequestMapping(value = "/update_login_info/file/acc_num", method = RequestMethod.POST)
	@ResponseBody
	public List<WebLoginInfo> updateWebLoginInfoByAccNum(@RequestParam(value = "file") MultipartFile file,
			HttpServletRequest request) throws Exception {
		String[] accNums = this.parse(file.getInputStream());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		WebLoginInfo webLoginInfo = new WebLoginInfo();
		webLoginInfo.setLoginAttempt(Integer.parseInt(request.getParameter("loginAttempt")));
		webLoginInfo.setFirstLogin(request.getParameter("firstLogin"));
		webLoginInfo.setBlockLogin(request.getParameter("blockLogin"));
		webLoginInfo.setLastChangePwdTime(format.parse(request.getParameter("lastChangePwdTime")));
		webLoginInfo.setPassword(request.getParameter("password"));
		webLoginService.updateWebLoginInfoByAccNum(accNums, webLoginInfo);
		return webLoginService.getWebLoginInfoListByAccNum(accNums);
	}

	@RequestMapping(value = "/update_login_info/file/login_name", method = RequestMethod.POST)
	@ResponseBody
	public List<WebLoginInfo> updateWebLoginInfoByLoignName(@RequestParam(value = "file") MultipartFile file,
			HttpServletRequest request) throws Exception {
		String[] loginNames = this.parse(file.getInputStream());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		WebLoginInfo webLoginInfo = new WebLoginInfo();
		webLoginInfo.setLoginAttempt(Integer.parseInt(request.getParameter("loginAttempt")));
		webLoginInfo.setFirstLogin(request.getParameter("firstLogin"));
		webLoginInfo.setBlockLogin(request.getParameter("blockLogin"));
		webLoginInfo.setLastChangePwdTime(format.parse(request.getParameter("lastChangePwdTime")));
		webLoginInfo.setPassword(request.getParameter("password"));
		webLoginService.updateWebLoginInfoByLoignName(loginNames, webLoginInfo);
		return webLoginService.getWebLoginInfoListByLoginName(loginNames);
	}

	private String[] parse(InputStream inputStream) throws IOException {
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

}