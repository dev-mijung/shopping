package com.nuri.shopping.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.nuri.shopping.model.CartVO;
import com.nuri.shopping.model.CateVO;
import com.nuri.shopping.model.EventVO;
import com.nuri.shopping.model.PayVO;
import com.nuri.shopping.model.UserVO;
import com.nuri.shopping.model.excelVO;

public interface UserService {
  

    public int insertData(String idx, String conatent);
  
	/**
	 * USER INSERT
	 * @param userVO
	 * @return
	 */
	public int userInsert(UserVO userVO);
	
	/**
	 * 아이디 중복확인
	 * @param user_id
	 * @return
	 */
	public int checkID(String user_id);
	
	/**
	 * 로그인 처리
	 * @param user_id
	 * @param user_passwd
	 * @return
	 */
	public int login(String user_id, String user_passwd);
	
	/**
	 * user_id에 해당하는 회원정보 불러오기
	 * @param user_id
	 * @return
	 */
	public UserVO readById(String user_id);
	
	/**
	 * category_idx에 해당하는 리스트 불러오기
	 * @param category_idx
	 * @return
	 */
	public List<CateVO> getProducts(int category_idx);
	
	/**
	 * 상품검색
	 * @param cate_name
	 * @return
	 */
	public List<CateVO> getSearch(String cate_name);
	
	/**
	 * 상품 상세페이지
	 * @param cate_idx
	 * @return
	 */
	public CateVO getDetail(int cate_idx);
	
	/**
	 * 장바구니 담기
	 * @param cate_idx
	 * @return
	 */
	public int addCart(CartVO cartVO);
	
	/**
	 * 장바구니리스트
	 * @param user_id
	 * @return
	 */
	public List<CartVO> getCartList(String user_id);
	
	/**
	 * 낮은 가격순 정렬
	 * @param category_idx
	 * @return
	 */
	public List<CateVO> orderByCatePriceAsc(int category_idx);
	
	/**
	 * 높은 가격순 정렬
	 * @param category_idx
	 * @return
	 */
	public List<CateVO> orderByCatePriceDesc(int category_idx);
	
	/**
	 * 최신 날짜순 정렬
	 * @param category_idx
	 * @return
	 */
	public List<CateVO> orderByDate(int category_idx);
	
	/**
	 * 회원별 정보 조회
	 * @param user_id
	 * @return
	 */
	public UserVO getUserInfo(String user_id);
	
	/**
	 * 구매하기 클릭시 구매테이블에 저장
	 * @param payVO
	 * @return
	 */
	public int addPay(PayVO payVO);
	
	/**
	 * 마이페이지
	 * @param user_id
	 * @return
	 */
	public List<PayVO> goMyPage(String user_id);
	
	/**
	 * 이벤트 페이지 이동
	 * @param event_idx
	 * @return
	 */
	public EventVO goEvent(int event_idx);
	
	/**
	 * 구매한 내역 삭제
	 * @param cart_idx
	 * @param user_id
	 * @return
	 */
	public int deleteProduct(Integer checkArr);
	
	/**
     * cart_idx, user_id에 해당하는 장바구니 조회
     * @param cart_idx
     * @param user_idx
     * @return
     */
    public List<CartVO> selectCart(Integer checkArr);
		
}
