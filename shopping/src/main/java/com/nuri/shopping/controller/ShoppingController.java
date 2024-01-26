package com.nuri.shopping.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.Gson;
import com.nuri.shopping.model.CartVO;
import com.nuri.shopping.model.CateVO;
import com.nuri.shopping.model.EventVO;
import com.nuri.shopping.model.PayVO;
import com.nuri.shopping.model.UserVO;
import com.nuri.shopping.model.excelVO;
import com.nuri.shopping.service.UserService;

@Controller
@RequestMapping(value="/shop")
public class ShoppingController {
	@Autowired
	UserService service;

	
	/**
	 * 회원가입 폼으로 이동
	 * @return
	 */
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public ModelAndView userInsert() {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/user/signup");
		
		return mav;

	}

	/**
	 * 회원가입
	 * @param userVO
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/signup", method=RequestMethod.POST)
	public String userInsert(UserVO userVO) {
		System.out.println("UserVO: " + userVO);
		int cnt = service.userInsert(userVO);
		
		JSONObject json = new JSONObject();
		try {
			json.put("cnt", cnt);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json.toString();
	}
	
	/**
	 * 회원아이디 중복체크
	 * @param user_id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/checkID", method=RequestMethod.GET, produces="text/plain;charset=UTF-8")
	public String checkID(String user_id) {
		//System.out.println("ajax성공");
		//System.out.println("user_id: " + user_id);
		
		int cnt = service.checkID(user_id);
		
		//System.out.println("check id cnt: " + cnt);
		
		JSONObject json = new JSONObject();
		try {
			json.put("cnt", cnt);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json.toString();
	}
	
	/**
	 * 로그인 폼
	 * @param user_id
	 * @param user_passwd
	 * @return
	 */
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/user/login");
		return mav;
	}
	
	/**
	 * 로그인 처리
	 * @param user_id
	 * @param user_passwd
	 * @return
	 */
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request, 
            HttpServletResponse response,HttpSession session, String user_id, String user_passwd) {
		ModelAndView mav = new ModelAndView();
		
		System.out.println("로그인진입");
		int cnt = service.login(user_id, user_passwd);
		
		UserVO userVO = new UserVO();
		System.out.println("cnt: " + cnt);
		if(cnt == 1) {
			userVO = service.readById(user_id);
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_name", userVO.getUser_name());
			mav.setViewName("redirect:/");
			System.out.println("로그인성공");
		} else {
		  System.out.println("로그인실패");
		}
		return mav;
	}
	
	/**
	 * 로그아웃 처리
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public ModelAndView logout(HttpSession session) {
		//System.out.println("로그아웃진입");
		ModelAndView mav = new ModelAndView();
		session.invalidate();
		mav.setViewName("redirect:/");
		//System.out.println("로그아웃성공");
		return mav;
	}
	
	/**
	 * categrp_idx에 해당하는 상품리스트 가져오기(ajax통신)
	 * @param categrp_idx
	 * @return
	 */
	@RequestMapping(value="/getproducts", method = RequestMethod.GET)
	public @ResponseBody String getProducts(Model model, int category_idx) {
		
		System.out.println("getproducts 진입");
		System.out.println("category_idx: " + category_idx);
		
		Gson gson = new Gson();
		
		
		List<CateVO> cate_list = service.getProducts(category_idx);
		//category_idx = cate_list.get(0).getCategory_idx();
		
		model.addAttribute("category_idx", category_idx);
		System.out.println("cate_list: " + cate_list);
		
		return gson.toJson(cate_list);
	}
	
	/**
	 * 상품검색
	 * @param cate_name
	 * @return
	 */
	@RequestMapping(value="/getsearch", method = RequestMethod.GET)
	public @ResponseBody String getProducts(String cate_name) {
		
		System.out.println("getsearch 진입");
		System.out.println("cate_name: " + cate_name);
		
		Gson gson = new Gson();
		
		List<CateVO> cate_cate_list = service.getSearch(cate_name);
		System.out.println("cate_cate_list: " + cate_cate_list);
		
		
		return gson.toJson(cate_cate_list);
	}
	
	/**
	 * 상품 상세페이지
	 * @param cate_idx
	 * @return
	 */
	@RequestMapping(value="/getdetail", method = RequestMethod.GET)
	public String getDetail(Model model, int cate_idx,
			HttpServletRequest request, 
            HttpServletResponse response,HttpSession session) {
		
		//System.out.println("session.getAttribute(\"user_idx\"): " + session.getAttribute("user_idx"));
		
		CateVO detail = service.getDetail(cate_idx);
		model.addAttribute("detail", detail);
		model.addAttribute("user_id", session.getAttribute("user_id"));
		
		return "/user/detail";
	}
	
	/**
	 * 장바구니 추가
	 * @param model
	 * @param cate_idx
	 * @return
	 */
	@RequestMapping(value="/addcart", method = RequestMethod.POST)
	public @ResponseBody String addCart(CartVO cartVO) {

		Gson gson = new Gson();
		int cnt = service.addCart(cartVO);
		System.out.println("cartVO: " + cartVO);
		
		return gson.toJson(cnt);
	}
	
	/**
	 * 장바구니 리스트 불러오기
	 * @param model
	 * @param user_id
	 * @return
	 */
	@RequestMapping(value="/getcartlist", method = RequestMethod.GET)
	public String getCartList(Model model, String user_id) {
		
		//System.out.println("진입: " + user_idx);
		UserVO userInfo = service.getUserInfo(user_id);
		
		List<CartVO> cart_list = service.getCartList(user_id);
		model.addAttribute("cart_list", cart_list);
		model.addAttribute("userInfo", userInfo);
		
		System.out.println("cart_list: " + cart_list);
		
		return "/user/cart";
	}
	
	/**
	 * 낮은가격순으로 정렬
	 * @param categrp_idx
	 * @return
	 */
	@RequestMapping(value="/priceasc", method = RequestMethod.GET)
	public @ResponseBody String orderByCatePriceAsc(int category_idx) {
		
		//System.out.println("priceasc 진입");
		//System.out.println("category_idx: " + category_idx);
		
		Gson gson = new Gson();
		
		
		List<CateVO> asc_list = service.orderByCatePriceAsc(category_idx);
		
		return gson.toJson(asc_list);
	}
	
	/**
	 * 높은가격순으로 정렬
	 * @param categrp_idx
	 * @return
	 */
	@RequestMapping(value="/pricedesc", method = RequestMethod.GET)
	public @ResponseBody String orderByCatePriceDesc(int category_idx) {
		
		//System.out.println("pricedesc 진입");
		//System.out.println("category_idx: " + category_idx);
		
		Gson gson = new Gson();
		
		
		List<CateVO> desc_list = service.orderByCatePriceDesc(category_idx);
		
		return gson.toJson(desc_list);
	}
	
	/**
	 * 최신순으로 정렬
	 * @param categrp_idx
	 * @return
	 */
	@RequestMapping(value="/orderbydate", method = RequestMethod.GET)
	public @ResponseBody String orderByDate(int category_idx) {
		
		//System.out.println("orderbydate 진입");
		//System.out.println("category_idx: " + category_idx);
		
		Gson gson = new Gson();
		
		
		List<CateVO> date_list = service.orderByDate(category_idx);
		
		return gson.toJson(date_list);
	}
	
	/**
	 * 구매하기 클릭 시 구매테이블에 저장
	 * @param model
	 * @param payVO
	 * @return
	 */
	@RequestMapping(value="/addpay", method = RequestMethod.GET)
	public @ResponseBody String addPay(Model model,
			//@JsonProperty PayVO payVO,
	        String user_id, 
			@RequestParam(value="checkArr[]") List<Integer> checkArr,
  	        HttpServletRequest request, 
  	        HttpServletResponse response,HttpSession session
//        	@RequestParam(value="cate_name") List<String> cate_name
  	        )
			 {
			 
		
		//System.out.println("orderbydate 진입");
		//System.out.println("category_idx: " + category_idx);
		System.out.println("checkArr:" + checkArr);
		//System.out.println("cate_idx:" + cate_idx);
		//System.out.println("user_idx:" + user_idx);
		
		// System.out.println("payVO" + payVO);
		//int user_idx = (Integer) session.getAttribute("user_idx");
		Gson gson = new Gson();
		List<CartVO> cart = new ArrayList<CartVO>();
		PayVO payVO = new PayVO();
		int cnt = 0;
		for(int i=0; i<checkArr.size(); i++) {
		  System.out.println("checkArr.get(i): " + checkArr.get(i));
		  cart.addAll(service.selectCart(checkArr.get(i)));
		  
		  System.out.println("cart: " + cart);
		}
		
		for(int i=0; i<cart.size(); i++) {
		  payVO.setUser_id(cart.get(i).getUser_id());
          payVO.setCate_name(cart.get(i).getCart_name());
          payVO.setCate_img(cart.get(i).getCart_img());
          payVO.setCate_price(cart.get(i).getCart_price());
          payVO.setCate_idx(cart.get(i).getCart_idx());
          System.out.println("payVO: " + payVO);
          cnt = service.addPay(payVO);
		}
		System.out.println("구매테이블에 저장완료");
		//System.out.println("cart_size: " + cart.size());
		
		// int cnt = service.addPay(payVO);
		
		for(int i=0; i<checkArr.size(); i++) {
		  service.deleteProduct(checkArr.get(i));
        }
		System.out.println("구매내역 장바구니에서 삭제");
		
		
		return gson.toJson(cnt);
	}
	
	/**
	 * 마이페이지(회원구매내역)로 이동
	 * @param user_id
	 * @return
	 */
	@RequestMapping(value="/mypage", method = RequestMethod.GET)
	public String goMyPage(Model model, String user_id) {
		
		System.out.println("마이페이지 진입");
		List<PayVO> my_list = service.goMyPage(user_id);
		model.addAttribute("my_list", my_list);
		
		UserVO userInfo = service.getUserInfo(user_id);
		model.addAttribute("userInfo", userInfo);
		System.out.println("my_list: " + my_list);
		return "/user/mypage";
	}
	
	/**
	 * 이벤트페이지 이동
	 * @param model
	 * @param event_idx
	 * @return
	 */
	@RequestMapping(value="/goevent", method = RequestMethod.GET)
	public String goEvent(Model model, int event_idx) {
		
		EventVO eventVO = service.goEvent(event_idx);
		model.addAttribute("eventVO", eventVO);
		
		return "/user/event";
	}
	
	/**
	 *  db에 엑셀내용  insert
	 */
	@RequestMapping(value="/insertData", method = RequestMethod.GET)
	public void insertData() throws FileNotFoundException {
	  try {
	    
      FileInputStream file = new FileInputStream("C:/ai1/ws_frame/excel_test.xlsx");
      XSSFWorkbook workbook = new XSSFWorkbook(file);

      // sheet수 확인
      //int sheetCn = workbook.getNumberOfSheets();
      XSSFSheet sheet = workbook.getSheetAt(0); // 0번째 sheet 가져 옴
       
      int rowNo = 0; 
      int cellIndex = 0;
      double valueNum = 0;
      int rows = sheet.getPhysicalNumberOfRows(); // 엑셀의 행의 갯수
      String string_idx="";
      excelVO vo = new excelVO();
      String value = "";
      
      for(rowNo=0; rowNo < rows; rowNo++) {
        XSSFRow row = sheet.getRow(rowNo);
        if(row != null) {
          int cells = row.getPhysicalNumberOfCells();   // 엑셀의 열의 갯수
          for(cellIndex=0; cellIndex <= cells; cellIndex++) {
            XSSFCell cell = row.getCell(cellIndex); // 셀의 값을 가져온다
            if(cell == null) {  // 빈 셀 체크
              continue;
            } else {
              switch(cell.getCellType()) {
              case XSSFCell.CELL_TYPE_FORMULA:
                value = cell.getCellFormula();
                break;
           
              case XSSFCell.CELL_TYPE_NUMERIC:
                value = cell.getNumericCellValue() + "";
                valueNum = Double.parseDouble(value);
                int valueNum_ = (int) Math.round(valueNum); 
                String valueString = Integer.toString(valueNum_);
                string_idx = vo.setIdx(valueString);
                
                break;
              
              case XSSFCell.CELL_TYPE_STRING:
                value = cell.getStringCellValue() + "";
                if(value.equals("idx")) {
                  string_idx = vo.setIdx("idx");
                }
                System.out.println("string value: " + value);
                break;
                
              case XSSFCell.CELL_TYPE_BLANK:
                value = cell.getBooleanCellValue() + "";
                break;
                
              case XSSFCell.CELL_TYPE_ERROR:
                value = cell.getErrorCellValue() + "";
                break;
              }
            }
          }
          service.insertData(string_idx, value);
        }
        
      }
      
	  } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }
	}
}
