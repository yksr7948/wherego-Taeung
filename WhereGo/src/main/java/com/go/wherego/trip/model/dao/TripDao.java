package com.go.wherego.trip.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
		
		return sqlSession.selectOne("tripMapper.selectCount", contentId);
	}
	
	//댓글 리스트
	public ArrayList<Reply> replyList(SqlSessionTemplate sqlSession, String contentId) {

		return (ArrayList)sqlSession.selectList("tripMapper.replyList", contentId);
	}
	
	//댓글 작성
	public int insertReply(SqlSessionTemplate sqlSession, Reply r) {
		
		return sqlSession.insert("tripMapper.insertReply", r);
	}

}
