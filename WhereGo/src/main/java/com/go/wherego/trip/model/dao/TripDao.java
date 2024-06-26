package com.go.wherego.trip.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.go.wherego.trip.model.vo.Likes;
import com.go.wherego.trip.model.vo.PageInfo;
import com.go.wherego.trip.model.vo.Reply;
import com.go.wherego.trip.model.vo.Trip;

@Repository
public class TripDao {

	//데이터 저장
	public int saveArea(ArrayList<Trip> list, SqlSessionTemplate sqlSession){
			
		return sqlSession.insert("tripMapper.saveArea",list);
	}
		
	//여행지 총 개수
	public int listCount(SqlSessionTemplate sqlSession) {
			
		return sqlSession.selectOne("tripMapper.listCount");
	}
	
	//지역별 여행지 총 개수
	public int areaListCount(SqlSessionTemplate sqlSession, String areaCode) {

		return sqlSession.selectOne("tripMapper.areaListCount",areaCode); 
	}
		
	//여행지 목록 조회
	public ArrayList<Trip> selectList(SqlSessionTemplate sqlSession,PageInfo pi){
			
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
			
		RowBounds rowBounds = new RowBounds(offset,limit);
			
		return (ArrayList)sqlSession.selectList("tripMapper.selectList", null, rowBounds);
	}
	
	//지역별 여행지 목록 조회
	public ArrayList<Trip> selectAreaList(SqlSessionTemplate sqlSession, PageInfo pi, String areaCode){
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage()-1)*limit;
			
		RowBounds rowBounds = new RowBounds(offset,limit);
			
		return (ArrayList)sqlSession.selectList("tripMapper.selectAreaList", areaCode, rowBounds);
	}

	//조회수 증가
	public int increaseCount(SqlSessionTemplate sqlSession, String contentId) {

		return sqlSession.update("tripMapper.increaseCount", contentId);
		
	}
	
	//조회수 가져오기
	public int selectCount(SqlSessionTemplate sqlSession, String contentId) {
		
		Integer count = sqlSession.selectOne("tripMapper.selectCount", contentId);
	    return (count == null) ? 0 : count;
	}
	
	//좋아요 count 조회
	public int selectLikeCount(SqlSessionTemplate sqlSession, String contentId) {
		
		return sqlSession.selectOne("tripMapper.selectLikeCount", contentId);
	}
	
	//좋아요 여부
	public boolean likeYN(SqlSessionTemplate sqlSession, Likes like) {
		
		String userId = sqlSession.selectOne("tripMapper.likeYN", like);
		
		boolean flag = false;
		
		if(userId == null) {
			flag = false;
		}else {
			flag = true;
		}
		
		return flag;
	}
	
	//좋아요 정보 추가
	public int insertLike(SqlSessionTemplate sqlSession, Likes like) {
		
		return sqlSession.insert("tripMapper.insertLike", like);
	}
	
	//좋아요 count 증가
	public int increaseLike(SqlSessionTemplate sqlSession, Likes like) {
		
		return sqlSession.update("tripMapper.increaseLike", like);
	}
	
	//좋아요 count 감소
	public int decreaseLike(SqlSessionTemplate sqlSession, Likes like) {
		
		return sqlSession.update("tripMapper.decreaseLike", like);
	}
	
	//좋아요 정보 삭제
	public int deleteLike(SqlSessionTemplate sqlSession, Likes like) {
		
		return sqlSession.delete("tripMapper.deleteLike", like);
	}
	
	//댓글 리스트
	public ArrayList<Reply> replyList(SqlSessionTemplate sqlSession, String contentId) {

		return (ArrayList)sqlSession.selectList("tripMapper.replyList", contentId);
	}
	
	//댓글 작성
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		
		return sqlSession.insert("tripMapper.insertReply", r);
	}
	
	//댓글 수정
	public int updateReply(SqlSessionTemplate sqlSession, Reply r) {
		
		return sqlSession.update("tripMapper.updateReply", r);
	}
	
	//댓글 삭제
	public int deleteReply(SqlSessionTemplate sqlSession, int replyNo) {
		
		return sqlSession.delete("tripMapper.deleteReply", replyNo);
	}

}
