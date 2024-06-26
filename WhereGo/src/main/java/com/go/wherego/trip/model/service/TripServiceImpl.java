package com.go.wherego.trip.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.go.wherego.trip.model.dao.TripDao;
import com.go.wherego.trip.model.vo.Likes;
import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Reply;
import com.go.wherego.trip.model.vo.Trip;


@Service
public class TripServiceImpl implements TripService{

	@Autowired
	private TripDao tripDao;
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	//데이터 저장
	@Override
	public int saveArea(ArrayList<Trip> list) {
		
		int result = tripDao.saveArea(list, sqlSession);
		
		return result;
	}
	
	//여행지 총 개수
	@Override
	public int listCount() {
		
		int listCount = tripDao.listCount(sqlSession);
		
		return listCount;
	}
	
	//지역별 여행지 총 개수
	@Override
	public int areaListCount(String areaCode) {
			
		int listCount = tripDao.areaListCount(sqlSession, areaCode);
			
		return listCount;
	}
	
	//여행지 목록 조회
	@Override
	public ArrayList<Trip> selectList(PageInfo pi){
		
		ArrayList<Trip> tList = tripDao.selectList(sqlSession, pi);
		
		return tList;
	}
	
	//지역별 여행지 목록 조회
	@Override
	public ArrayList<Trip> selectAreaList(PageInfo pi, String areaCode){
			
		ArrayList<Trip> aList = tripDao.selectAreaList(sqlSession, pi, areaCode);
			
		return aList;
	}
	
	//조회수 증가
	@Override
	public int increaseCount(String contentId) {
		
		int result = tripDao.increaseCount(sqlSession, contentId);
		
		return result;
	}
	
	//조회수 가져오기
	@Override
	public int selectCount(String contentId) {
		
		int count = tripDao.selectCount(sqlSession, contentId);
		
		return count;
	}
	
	//좋아요 count 조회
	@Override
	public int selectLikeCount(String contentId) {
		
		int likeCount = tripDao.selectLikeCount(sqlSession, contentId);
		
		return likeCount;
	}
	
	//좋아요 여부
	@Override
	public boolean likeYN(Likes like) {
		
		boolean flag = tripDao.likeYN(sqlSession, like);
		
		return flag;
	}
	
	//좋아요 정보 추가
	@Override
	public int insertLike(Likes like) {
		
		int result = tripDao.insertLike(sqlSession, like);
		
		return result;
	}
	
	//좋아요 count 증가
	public int increaseLike(Likes like) {
		
		int result = tripDao.increaseLike(sqlSession, like);
		
		return result;
	}
	
	//좋아요 count 감소
	public int decreaseLike(Likes like) {
		
		int result = tripDao.decreaseLike(sqlSession, like);
		
		return result;
	}
	
	//좋아요 정보 삭제
	@Override
	public int deleteLike(Likes like) {
		
		int result = tripDao.deleteLike(sqlSession, like);
		
		return result;
	}
	
	//댓글 리스트
	@Override
	public ArrayList<Reply> replyList(String contentId){
		
		ArrayList<Reply> rList = tripDao.replyList(sqlSession, contentId);
		
		return rList;
	}
	
	//댓글 작성
	@Override
	public int insertReply(Reply r) {
		
		int result = tripDao.insertReply(sqlSession, r);
		
		return result;
	}
	
	//댓글 수정
	@Override
	public int updateReply(Reply r) {
		
		int result = tripDao.updateReply(sqlSession, r);
		
		return result;
	}
	
	//댓글 삭제
	@Override
	public int deleteReply(int replyNo) {
		
		int result = tripDao.deleteReply(sqlSession, replyNo);
		
		return result;
	}
}
