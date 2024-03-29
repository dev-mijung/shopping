package com.nuri.shopping.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.hssf.extractor.ExcelExtractor;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.extractor.XSSFExcelExtractor;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nuri.shopping.mapper.UserMapper;
import com.nuri.shopping.model.CartVO;
import com.nuri.shopping.model.CateVO;
import com.nuri.shopping.model.EventVO;
import com.nuri.shopping.model.PayVO;
import com.nuri.shopping.model.UserVO;
import com.nuri.shopping.model.excelVO;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	UserMapper mapper;
	
	@Override
	public int userInsert(UserVO userVO) {
		return mapper.userInsert(userVO);
	}

	@Override
	public int checkID(String user_id) {
		//System.out.println("service impl user_id: " + user_id);
		return mapper.checkID(user_id);
	}

	@Override
	public int login(String user_id, String user_passwd) {
		return mapper.login(user_id, user_passwd);
	}

	@Override
	public UserVO readById(String user_id) {
		return mapper.readById(user_id);
	}

	@Override
	public List<CateVO> getProducts(int category_idx) {
		return mapper.getProducts(category_idx);
	}

	@Override
	public List<CateVO> getSearch(String cate_name) {
		return mapper.getSearch(cate_name);
	}

	@Override
	public CateVO getDetail(int cate_idx) {
		return mapper.getDetail(cate_idx);
	}

	@Override
	public int addCart(CartVO cartVO) {
		return mapper.addCart(cartVO);
	}

	@Override
	public List<CartVO> getCartList(String user_id) {
		return mapper.getCartList(user_id);
	}

	@Override
	public List<CateVO> orderByCatePriceAsc(int category_idx) {
		return mapper.orderByCatePriceAsc(category_idx);
	}

	@Override
	public List<CateVO> orderByCatePriceDesc(int category_idx) {
		return mapper.orderByCatePriceDesc(category_idx);
	}

	@Override
	public List<CateVO> orderByDate(int category_idx) {
		return mapper.orderByDate(category_idx);
	}

	@Override
	public UserVO getUserInfo(String user_id) {
		return mapper.getUserInfo(user_id);
	}

	@Override
	public int addPay(PayVO payVO) {
		return mapper.addPay(payVO);
	}

	@Override
	public List<PayVO> goMyPage(String user_id) {
		return mapper.goMyPage(user_id);
	}

	@Override
	public EventVO goEvent(int event_idx) {
		return mapper.goEvent(event_idx);
	}

	@Override
	public int deleteProduct(Integer checkArr) {
		return mapper.deleteProduct(checkArr);
	}

    @Override
    public List<CartVO> selectCart(Integer checkArr) {
      return mapper.selectCart(checkArr);
    }

    @Override
    public int insertData(String set_idx, String content) {
      return mapper.insertData(set_idx, content);
    }

}
