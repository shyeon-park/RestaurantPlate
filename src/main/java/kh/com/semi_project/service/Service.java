package kh.com.semi_project.service;

import java.util.ArrayList;
import java.util.HashMap;

import kh.com.semi_project.dao.ListDAO;
import kh.com.semi_project.dao.ViewDAO;
import kh.com.semi_project.dto.ListDTO;
import kh.com.semi_project.dto.ViewDTO;

// request, response 랑 직접적인 관련이 없는 
// 특정한 객체(board)와 관련된 비니지스 로직을 여기 , Service 클래스에서 처리
// paging 
public class Service {
	private ViewDAO dao = new ViewDAO();
	private ListDAO ldao = new ListDAO();
	private int recordCntPerPage = 10;
	private int naviCntPerPage = 10;
	
	// 리뷰관련 페이징
	public HashMap<String, Object> getPageNavi(int currentPage){
		try {
			int recordTotalCnt = dao.countAll(); // 전체 데이터 수
			
			int pageTotalCnt = 0; // 총 몇 페이지가 나올지
			if(recordTotalCnt % recordCntPerPage > 0) {
				pageTotalCnt = (recordTotalCnt / recordCntPerPage) + 1;
			}else {
				pageTotalCnt = recordTotalCnt / recordCntPerPage;
			}
			
			if(currentPage < 1) { // currentPage 안전장치
				currentPage = 1;
			}else if(currentPage > pageTotalCnt) {
				currentPage = pageTotalCnt;
			}
			
			// 시작 네비 페이지, 끝 네비 페이지 잡아주기 
			int startNavi = ((currentPage -1) / naviCntPerPage) * naviCntPerPage + 1;
			int endNavi = startNavi + naviCntPerPage - 1;
			
			if(endNavi > pageTotalCnt) { // endNavi 총 페이지 수를 초과되지 않게 맞춰주기.
				endNavi = pageTotalCnt;
			}
			
			// 이전, 다음 버튼 필요 여부 셋팅
			boolean needPrev = true;
			boolean needNext = true;
			if(startNavi == 1) needPrev = false;
			if(endNavi == pageTotalCnt) needNext = false;
			
			System.out.println("startNavi : " + startNavi);
			System.out.println("endNavi : " + endNavi);
			System.out.println("needPrev : " + needPrev);
			System.out.println("needNext : " + needNext);
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("startNavi", startNavi);
			map.put("endNavi", endNavi);
			map.put("needPrev", needPrev);
			map.put("needNext", needNext);
			map.put("currentPage", currentPage);
			
			return map;	
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
		
	}
	
	public ArrayList<ViewDTO> getViewList(int currentPage){
		int startRange = currentPage * recordCntPerPage - (recordCntPerPage-1);
		int endRange = currentPage * recordCntPerPage;
		try {
			ArrayList<ViewDTO> list = dao.getViewList(startRange, endRange);
			for(ViewDTO dto : list) {
				System.out.println(dto.getSeq_rest() + " : " + dto.getSeq_view() + " : " +
						dto.getUser_id() + " : " + dto.getReview_content() + " : " + dto.getReview_date());
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	// 리스트 관련 페이징
	public HashMap<String, Object> getListPageNavi(int currentPage){
		try {
			int recordTotalCnt = ldao.listCountAll(); // 전체 데이터 수
			
			int pageTotalCnt = 0; // 총 몇 페이지가 나올지
			if(recordTotalCnt % recordCntPerPage > 0) {
				pageTotalCnt = (recordTotalCnt / recordCntPerPage) + 1;
			}else {
				pageTotalCnt = recordTotalCnt / recordCntPerPage;
			}
			
			if(currentPage < 1) { // currentPage 안전장치
				currentPage = 1;
			}else if(currentPage > pageTotalCnt) {
				currentPage = pageTotalCnt;
			}
			
			// 시작 네비 페이지, 끝 네비 페이지 잡아주기 
			int startNavi = ((currentPage -1) / naviCntPerPage) * naviCntPerPage + 1;
			int endNavi = startNavi + naviCntPerPage - 1;
			
			if(endNavi > pageTotalCnt) { // endNavi 총 페이지 수를 초과되지 않게 맞춰주기.
				endNavi = pageTotalCnt;
			}
			
			// 이전, 다음 버튼 필요 여부 셋팅
			boolean needPrev = true;
			boolean needNext = true;
			if(startNavi == 1) needPrev = false;
			if(endNavi == pageTotalCnt) needNext = false;
			
			System.out.println("startNavi : " + startNavi);
			System.out.println("endNavi : " + endNavi);
			System.out.println("needPrev : " + needPrev);
			System.out.println("needNext : " + needNext);
			
			HashMap<String, Object> map = new HashMap<>();
			map.put("startNavi", startNavi);
			map.put("endNavi", endNavi);
			map.put("needPrev", needPrev);
			map.put("needNext", needNext);
			map.put("currentPage", currentPage);
			
			return map;	
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
		
	}
	
	public ArrayList<ListDTO> getRestaurantList(int currentPage){
		int startRange = currentPage * recordCntPerPage - (recordCntPerPage-1);
		int endRange = currentPage * recordCntPerPage;
		try {
			ArrayList<ListDTO> list = ldao.getRestaurantList(startRange, endRange);
			for(ListDTO dto : list) {
				System.out.println(dto.getSeq_list() + " : " + dto.getList_title());
			}
			return list;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
